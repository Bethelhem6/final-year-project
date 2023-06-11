import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/search/result.dart';
import 'package:flutter/material.dart';

import '../home/detail_page.dart';

class SearchHouse extends StatefulWidget {
  const SearchHouse({super.key});

  @override
  State<SearchHouse> createState() => _SearchHouseState();
}

class _SearchHouseState extends State<SearchHouse> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference ref = FirebaseFirestore.instance.collection("houses");
  String address = "";

  String whatFor = 'Rent';

  List<DropdownMenuItem<String>> get options {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Rent", child: Text("Rent")),
      const DropdownMenuItem(value: "Sell", child: Text("Sell")),
    ];
    return menuItems;
  }

  String category = 'Villa';
  List<DropdownMenuItem<String>> get categories {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Villa", child: Text("Villa")),
      const DropdownMenuItem(value: "Apartment", child: Text("Apartment")),
      const DropdownMenuItem(value: "Real estate", child: Text("Real estate")),
      const DropdownMenuItem(value: "Condominium", child: Text("Condominium")),
    ];
    return menuItems;
  }

  String status = 'Finished';
  List<DropdownMenuItem<String>> get statuses {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Finished", child: Text("Finished")),
      const DropdownMenuItem(
          value: "Half-finished", child: Text("Half-finished")),
      // const DropdownMenuItem(value: "Half-finished", child: Text("Half-finished")),
    ];
    return menuItems;
  }

  var bedRoom = 0;
  var location = "";
  var bathRoom = 0;
  // CollectionReference ref2 = FirebaseFirestore.instance.collection("houses");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: appbarColor,
          title: TextFormField(
            style: const TextStyle(
                // color: Colors.white,
                ),
            // autofocus: true,
            onEditingComplete: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
            decoration: InputDecoration(
                enabled: true,
                suffixIcon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.grey.shade400,
                )),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                hintText: "Search with location...",
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade300,
                  fontSize: 18,
                )),
          ),
          toolbarHeight: 100,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Container(
                margin: const EdgeInsets.only(right: 40.0),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              onPressed: () {
                //  query = "";
                showBottomSheet(context);
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: ref.snapshots().asBroadcastStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if ((snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['address']
                          .toString()
                          .toLowerCase()
                          .contains(address.toLowerCase()))
                  .isEmpty)) {
                return const Center(
                  child: Text("Result not found"),
                );
                // }
              }
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    ...snapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) =>
                            element['address']
                                .toString()
                                .toLowerCase()
                                .contains(address.toLowerCase()))
                        .map(
                      (QueryDocumentSnapshot<Object?> data) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        bathRoom: data.get('bathRoom'),
                                        bedroom: data.get('bedRoom'),
                                        company: data.get('companyName'),
                                        description: data.get('description'),
                                        location: data.get('address'),
                                        price: data.get('price'),
                                        status: data.get('status'),
                                        likes: data.get('likes'),
                                        dateAdded: data.get('dateAdded'),
                                        image: data.get('imageUrls'),
                                        email: data.get('ownerEmail'),
                                        name: data.get('ownerName'),
                                        ownerImage: data.get('ownerImage'),
                                        area: data.get('area'),
                                        uid: data.get('id'),
                                        id: data.get('id')),
                                  ));
                            },
                            child: resultCard(
                                data.get('address'),
                                data.get('imageUrls')[0],
                                data.get('bedRoom'),
                                data.get('area'),
                                data.get('price'),
                                data.get("whatFor")));
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("No results found"),
                );
              }
            }));
  }

  Future<void> showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        elevation: 5,
        // backgroundColor: Colors.deepPurple.shade50,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 750,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 60),
                            child: Text(
                              'Customize your search',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 16.0),
                          Expanded(
                              child: DropdownButton(
                            value: category,
                            onChanged: (String? newValue) {
                              setState(() {
                                category = newValue!;
                              });
                            },
                            items: categories,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: DropdownButton(
                                  value: whatFor,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      whatFor = newValue!;
                                    });
                                  },
                                  items: options)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              // controller: _bedRoomController,
                              decoration: const InputDecoration(
                                labelText: 'Bed rooms',
                                prefixIcon:
                                    Icon(Icons.bed_outlined, color: Colors.red),
                              ),
                              keyboardType: TextInputType.number,

                              onChanged: (value) {
                                value.isEmpty
                                    ? "please enter how many bed room you want."
                                    : setState(() {
                                        bedRoom = int.parse(value);
                                      });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter how many bed rooms it has.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              // controller: _bathRoomController,
                              decoration: const InputDecoration(
                                labelText: 'Bath rooms',
                                prefixIcon: Icon(Icons.shower_outlined,
                                    color: Colors.blue),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                value.isEmpty
                                    ? 0
                                    : setState(() {
                                        bathRoom = int.parse(value);
                                      });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter how many bath rooms you want.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      color: Colors.deepPurple,
                      //  onPressed: _selectImage,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultCard(
                                  bathRoom: bathRoom,
                                  bedRoom: bedRoom,
                                  category: category,
                                  location: location,
                                  whatFor: whatFor),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ])));
        });
  }

  Stack resultCard(address, image, bedRoom, area, price, whatFor) {
    return Stack(children: [
      Container(
        // padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 214, 211, 211),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 270,

        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "$area \nsq.ft",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300,
                      // color: textPrimaryDarkColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Text(
                    "$bedRoom Bedrooms \nin $address",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300,
                      // color: textPrimaryDarkColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Birr $price",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300,
                      // color: textPrimaryDarkColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 3)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ]),
            child: Text(
              "For $whatFor",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ))
    ]);
  }
}
