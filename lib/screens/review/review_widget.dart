// // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsWidget extends StatelessWidget {
  ReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("reviews").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          var doc = snapshot.data!.docs;

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return snapshot.data!.docs.isEmpty
                      ? SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "No reviews on this product",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 5),
                              child: Card(
                                elevation: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25, left: 20, bottom: 10),
                                      child: Text(
                                        doc[index]['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // width: 10,
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          child: RatingBar.builder(
                                            initialRating: doc[index]['stars'],
                                            minRating: doc[index]['stars'],
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            ignoreGestures: true,
                                            onRatingUpdate: (rating) {},
                                            updateOnDrag: true,
                                            itemSize: 20,
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                bottom: 10, right: 10),
                                            child: Text(
                                              doc[index]['reviewDate']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        bottom: 10,
                                        right: 20,
                                      ),
                                      child: Text(
                                        doc[index]['review'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                }),
          );
        });
  }
}
