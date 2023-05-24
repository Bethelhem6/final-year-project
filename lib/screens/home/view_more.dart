import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewMore extends StatefulWidget {
  final String collection;
  final String? whatFor;

  const ViewMore({Key? key, required this.collection, this.whatFor})
      : super(key: key);

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

String uid = "";
User? user = FirebaseAuth.instance.currentUser;

class _ViewMoreState extends State<ViewMore> {
  @override
  void initState() {
    super.initState();
    uid = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Available Houses"),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 70,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection(widget.collection)
              .where("whatFor", isEqualTo: widget.whatFor)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!.docs;

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 3 / 3,
                  ),
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        String location = "";
                        String company = '';
                        String description = '';
                        int price = 0;
                        int bedroom = 0;
                        int bathRoom = 0;
                        int likes = 0;
                        String dateAdded = "";
                        List imageUrl = [];
                        String name = "";
                        String email = "";
                        String ownerImage = "";
                        int area = 0;
                        String status = "";
                        String id = "";

                        setState(() {
                          location = data[index]["address"];
                          bedroom = data[index]["bedRoom"];
                          likes = data[index]["likes"];
                          bedroom = data[index]["bedRoom"];
                          name = data[index]['ownerName'];
                          email = data[index]['ownerEmail'];
                          bathRoom = data[index]["bathRoom"];
                          company = data[index]['companyName'];
                          description = data[index]['description'];
                          location = data[index]['address'];
                          price = data[index]['price'];
                          dateAdded = data[index]['dateAdded'];
                          imageUrl = data[index]['imageUrls'];
                          ownerImage = data[index]['ownerImage'];
                          area = data[index]["area"];
                          status = data[index]['status'];
                          id = data[index]['id'];
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    uid: uid,
                                    bathRoom: bathRoom,
                                    bedroom: bedroom,
                                    company: company,
                                    description: description,
                                    location: location,
                                    price: price,
                                    status: status,
                                    likes: likes,
                                    name: name,
                                    dateAdded: dateAdded,
                                    email: email,
                                    ownerImage: ownerImage,
                                    image: imageUrl,
                                    area: area,
                                    id: id,
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple[200],
                                image: DecorationImage(
                                    image: NetworkImage(
                                        data[index]['imageUrls'][0]),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: -5,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 80,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]["category"],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        " Birr ${data[index]["price"]}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
