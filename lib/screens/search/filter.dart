import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

import '../home/detail_page.dart';

class SearchHouse extends StatefulWidget {
  const SearchHouse({super.key});

  @override
  State<SearchHouse> createState() => _SearchHouseState();
}

class _SearchHouseState extends State<SearchHouse> {
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
          backgroundColor: appbarColor,
          title: TextFormField(
            style: const TextStyle(
              color: Colors.white,
            ),
            autofocus: true,
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
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                hintText:
                    "Search house using category (Villa, Apartments, COndominium)...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade100,
                  fontSize: 15,
                )),
          ),
          toolbarHeight: 100,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60)),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              onPressed: () {
                //  query = "";
                // showBottomSheet(context);
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
                      element['category']
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
                            element['category']
                                .toString()
                                .toLowerCase()
                                .contains(address.toLowerCase()))
                        .map(
                      (QueryDocumentSnapshot<Object?> data) {
                        final String title = data.get('category');
                        final String companyName = data.get('companyName');

                        // final double bedroom = data.get('bedroom');
                        // final String bathroom= data.get('bathroom');
                        // final String title = data.get('address');
                        // final String title = data.get('address');
                        // final String title = data.get('address');
                        // final String title = data.get('address');
                        // final String image = data.get('image');
                        // final String price = data.get('price');
                        return ListTile(
                          isThreeLine: true,

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
                                        status: data.get("whatFor"),
                                        likes: data.get('likes'),
                                        dateAdded: data.get('dateAdded'),
                                        image: data.get('imageUrls'),
                                        email: data.get('ownerEmail'),
                                        name: data.get('ownerName'),
                                        ownerImage: data.get('ownerImage'),
                                        area: data.get('area'),
                                        uid: data.get('ownerId'),
                                        id: data.get('id'))));
                          },
                          title: Text(title),
                          subtitle: Text(companyName),

                          leading: GestureDetector(
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
                            child: const Icon(
                              Icons.real_estate_agent,
                              color: Colors.deepPurple,
                            ),
                          ),
                          // subtitle: Text(price),
                        );
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
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 700,
              color: Colors.deepPurpleAccent.shade400,
              child: Center(
                  child: Form(
                      // key: _formKey,
                      child: Card(
                          elevation: 3,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Customize your filter',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
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
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFormField(
                                    // controller: _addressController,
                                    decoration: const InputDecoration(
                                      labelText: 'Location',
                                      prefixIcon: Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.purple),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter location of property';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    // controller: _bedRoomController,
                                    decoration: const InputDecoration(
                                      labelText: 'Bed rooms',
                                      prefixIcon: Icon(Icons.bed_outlined,
                                          color: Colors.black),
                                    ),
                                    keyboardType: TextInputType.number,
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
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: Center(
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: Colors.deepPurple,
                                  //  onPressed: _selectImage,
                                  onPressed: () {
                                    print(category);
                                    print(whatFor);
                                    searchFilter(category, whatFor, location,
                                        bedRoom, bathRoom);
                                  },
                                  child: const Text(
                                    'Result',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ])))));
        });
  }

  void searchFilter(String category, String whatFor, String location,
      int bedRoom, int bathRoom) {
    StreamBuilder(
        stream: ref.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if ((snapshot.data!.docs
              .where((QueryDocumentSnapshot<Object?> element) =>
                  element[location]
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
                        element[location]
                            .toString()
                            .toLowerCase()
                            .contains(address.toLowerCase()))
                    .map(
                  (QueryDocumentSnapshot<Object?> data) {
                    final String title = data.get('category');
                    final String companyName = data.get('companyName');
                    location = data.get('address');
                    List image = data.get('imageUrls');
                    String area = data.get('area');
                    int price = data.get('price');

                     return resultCard(address, image, bedRoom, area, price);
                    // return ListTile(
                    //   isThreeLine: true,

                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => DetailPage(
                    //                 bathRoom: data.get('bathRoom'),
                    //                 bedroom: data.get('bedRoom'),
                    //                 company: data.get('companyName'),
                    //                 description: data.get('description'),
                    //                 location: data.get('address'),
                    //                 price: data.get('price'),
                    //                 status: data.get("whatFor"),
                    //                 likes: data.get('likes'),
                    //                 dateAdded: data.get('dateAdded'),
                    //                 image: data.get('imageUrls'),
                    //                 email: data.get('ownerEmail'),
                    //                 name: data.get('ownerName'),
                    //                 ownerImage: data.get('ownerImage'),
                    //                 area: data.get('area'),
                    //                 uid: data.get('ownerId'),
                    //                 id: data.get('id'))));
                    //   },
                    //   title: Text(title),
                    //   subtitle: Text(companyName),

                    //   leading: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => DetailPage(
                    //                 bathRoom: data.get('bathRoom'),
                    //                 bedroom: data.get('bedRoom'),
                    //                 company: data.get('companyName'),
                    //                 description: data.get('description'),
                    //                 location: data.get('address'),
                    //                 price: data.get('price'),
                    //                 status: data.get('status'),
                    //                 likes: data.get('likes'),
                    //                 dateAdded: data.get('dateAdded'),
                    //                 image: data.get('imageUrls'),
                    //                 email: data.get('ownerEmail'),
                    //                 name: data.get('ownerName'),
                    //                 ownerImage: data.get('ownerImage'),
                    //                 area: data.get('area'),
                    //                 uid: data.get('id'),
                    //                 id: data.get('id')),
                    //           ));
                    //     },
                    //     child: const Icon(
                    //       Icons.real_estate_agent,
                    //       color: Colors.deepPurple,
                    //     ),
                    //   ),
                    //   // subtitle: Text(price),
                    // );
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("No results found"),
            );
          }
        });
  }

  Stack resultCard(address, image, bedRoom, area, price) {
    return Stack(children: [
      Container(
        // padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          color: textPrimaryLightColor,
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
                    style: TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                        color: textPrimaryDarkColor),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Text(
                    "$bedRoom Bedrooms \nin $address",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                        color: textPrimaryDarkColor),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Birr $price",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                        color: textPrimaryDarkColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
