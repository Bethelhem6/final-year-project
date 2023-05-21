import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class DataSearch extends SearchDelegate<String> {
  CollectionReference ref = FirebaseFirestore.instance.collection("houses");
  CollectionReference ref2 = FirebaseFirestore.instance.collection("houses");
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
  // String _searchText = '';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        // Use this to change the query's text style
        titleLarge: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,

        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.filter_list_rounded,
          color: Colors.deepPurple,
          size: 35,
        ),
        onPressed: () {
          //  query = "";
          showModalBottomSheet<void>(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                          child: DropdownButton(
                                        value: category,
                                        onChanged: (String? newValue) {
                                          // setState(() {
                                          //   category = newValue!;
                                          // });
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
                                                // setState(() {
                                                //   whatFor = newValue!;
                                                // });
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
                                            prefixIcon: Icon(
                                                Icons.shower_outlined,
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
                                        onPressed: () {},
                                        child: const Text(
                                          'Result',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                ])))));
              });
        },
      )
    ];
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.deepPurpleAccent,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ref.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return StreamBuilder(
            stream: ref2.snapshots().asBroadcastStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot2.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if ((snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['address']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .isEmpty) &&
                  (snapshot2.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['address']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
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
                                .contains(query.toLowerCase()))
                        .map(
                      (QueryDocumentSnapshot<Object?> data) {
                        final String title = data.get('address');
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
                                        status: status,
                                        likes: data.get('likes'),
                                        dateAdded: data.get('dateAdded'),
                                        image: data.get('imageUrls'),
                                        email: data.get('ownerEmail'),
                                        name: data.get('ownerName'),
                                        ownerImage: data.get('ownerImage'),
                                        area: data.get('area'),
                                        uid: data.get('id'),
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
              } else if (snapshot2.hasData) {
                return ListView(
                  children: [
                    ...snapshot2.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) =>
                            element['name']
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                        .map(
                      (QueryDocumentSnapshot<Object?> data) {
                        final String title = data.get('companyName');
                        // final String image = data.get('image');
                        // final String price = data.get('price');
                        return ListTile(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             detailInfo(id: data.get('id'),title: data.get('name'),)));
                          },
                          title: Text(title),
                          // leading: Image.network(image),
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
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
      // height: 800,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("houses")
              .where("whatFor", isEqualTo: "Sell")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              var doc = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    bathRoom: doc[index]["bathRoom"],
                                    bedroom: doc[index]["bedRoom"],
                                    company: doc[index]["companyName"],
                                    description: doc[index]["description"],
                                    location: doc[index]["address"],
                                    price: doc[index]["price"],
                                    status: status,
                                    likes: doc[index]["likes"],
                                    dateAdded: doc[index]["dateAdded"],
                                    image: doc[index]["imageUrls"],
                                    name: doc[index]["ownerName"],
                                    email: doc[index]["ownerEmail"],
                                    ownerImage: doc[index]["ownerImage"],
                                    area: doc[index]["area"],
                                    id: doc[index]["id"],
                                  )),
                        );
                      },
                      child: resultCard(
                          doc[index]["address"],
                          doc[index]["imageUrls"][0],
                          doc[index]["bedRoom"],
                          doc[index]["area"],
                          doc[index]["price"]),
                    );
                  });
            }
            return Container();
          }),
    )));
  }

  Stack resultCard(address, image, bedRoom, area, price) {
    return Stack(
      children: [
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
        // Positioned(
        //   top: 20,
        //   right: 20,
        //   child: Container(
        //     width: 50,
        //     height: 50,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50 / 2),
        //         color: backgroundColor),
        //     child: GestureDetector(
        //       onTap: (){

        //       },
        //       child: const Icon(
        //         Icons.favorite_border_outlined,
        //         color: Colors.red,
        //         size: 35,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
