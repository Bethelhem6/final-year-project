// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../home/detail_page.dart';

class ResultCard extends StatefulWidget {
  ResultCard(
      {super.key,
      required this.bathRoom,
      required this.bedRoom,
      required this.category,
      required this.location,
      required this.whatFor});
  String? category;
  String? whatFor;
  String? location;
  int? bedRoom;
  int? bathRoom;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filtered Results",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        // backgroundColor: appbarColor,
        centerTitle: true,
        toolbarHeight: 80,
        toolbarOpacity: 0.8,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("houses")
              .where("category", isEqualTo: widget.category)
              .where("whatFor", isEqualTo: widget.whatFor)
              .where("bedRoom", isEqualTo: widget.bedRoom)
              .where("bathRoom", isEqualTo: widget.bathRoom)
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
                    widget.category = doc[index].get('category');

                    final int bedRoom = doc[index].get('bedRoom');
                    final String address = doc[index].get('address');
                    final int area = doc[index].get('area');

                    final String image = doc[index].get('imageUrls')[0];
                    final int price = doc[index].get('price');
                    return Stack(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      bathRoom: doc[index].get('bathRoom'),
                                      bedroom: doc[index].get('bedRoom'),
                                      company: doc[index].get('companyName'),
                                      description:
                                          doc[index].get('description'),
                                      location: doc[index].get('address'),
                                      price: doc[index].get('price'),
                                      status: doc[index].get("whatFor"),
                                      likes: doc[index].get('likes'),
                                      dateAdded: doc[index].get('dateAdded'),
                                      image: doc[index].get('imageUrls'),
                                      email: doc[index].get('ownerEmail'),
                                      name: doc[index].get('ownerName'),
                                      ownerImage: doc[index].get('ownerImage'),
                                      area: doc[index].get('area'),
                                      uid: doc[index].get('ownerId'),
                                      id: doc[index].get('id'))));
                        },
                        child: resultWidget(image, area, bedRoom, address,
                            price, doc[index]["whatFor"]),
                      ),
                    ]);
                  });
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No data found :("),
              );
            }
            return const Center(
              child: Text("No data found :("),
            );
          }),
    );
  }

  Container resultWidget(String image, int area, int bedRoom, String address,
      int price, String whatFor) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 255, 253, 253),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        // color: textPrimaryLightColor,
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
    );
  }
}
