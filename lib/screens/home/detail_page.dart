// ignore_for_file: avoid_print, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/provider/whishlist_provider.dart';
import 'package:final_project/screens/chat/user_list_screen.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    super.key,
    required this.bathRoom,
    required this.bedroom,
    required this.company,
    required this.description,
    required this.location,
    required this.price,
    required this.status,
    required this.likes,
    required this.dateAdded,
    required this.image,
    required this.email,
    required this.name,
    required this.ownerImage,
    required this.area,
    required this.uid,
    required this.id,
  });
  String location;
  String company;
  String status;
  String description;
  int area;
  String dateAdded;
  int price;
  int bedroom;
  int bathRoom;
  List image;
  String name;
  String email;
  String ownerImage;
  String uid;
  String id;
  int likes;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLiked = false;
  String uid = "";

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    try {
      var likeCount = await FirebaseFirestore.instance
          .collection('Likes')
          .where("id", isEqualTo: widget.id)
          .get();

      widget.likes = likeCount.size;
      //Assuming I have a collection I would do like this
      await FirebaseFirestore.instance
          .collection("Likes")
          .doc("$uid${widget.id}")
          .get()
          .then((doc) async {
        //If such document exist I know the user has liked the image or media f
        if (doc.exists) {
          if (mounted) {
            setState(() {
              _isLiked = true;
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _toggleLikes() async {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        widget.likes > 0 ? widget.likes -= 1 : 0;
      } else {
        _isLiked = true;
        widget.likes += 1;
      }
    });

    try {
      if (_isLiked == true) {
        await FirebaseFirestore.instance
            .collection("Likes")
            .doc("$uid${widget.id}")
            .set({'value': true, "id": widget.id, "uid": uid});
        await FirebaseFirestore.instance
            .collection('houses')
            .doc(widget.id)
            .update({
          "likes": widget.likes,
        });
      } else {
        await FirebaseFirestore.instance
            .collection("Likes")
            .doc("$uid${widget.id}")
            .delete();
      }
    } catch (e) {
      print(e);
    }
    return !_isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final whishlistProvider = Provider.of<WhishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.company,
          style: const TextStyle(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 600,
              height: 300,
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
              child: Image.network(
                widget.image[0],
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: 600,
              height: 70,
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const AppIcon(
                              icon: Icons.location_on,
                              iconColor: Colors.deepPurple),
                        ),
                        const Text(
                          "Location",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            whishlistProvider.addOrRemoveWish(widget.id,
                                widget.company, widget.image, widget.price);
                            //   Whishlist wishlist = Whishlist(
                            //       image: productDoc['image'],
                            //       title: productDoc['title'],
                            //       price:  double.parse(productDoc['price']),
                            //       id: productDoc['id']);
                            //   var box = await Hive.openBox('wishlist_list');
                            //       box.put(productDoc['id'], wishlist);
                            print("addedddd");
                          },
                          icon: whishlistProvider.whishlist
                                  .containsKey(widget.company)
                              ? const AppIcon(
                                  icon: Icons.favorite,
                                  iconColor: Colors.red,
                                )
                              : const AppIcon(
                                  icon: Icons.favorite_outline,
                                  iconColor: Colors.deepPurple,
                                ),
                        ),
                        const Text(
                          "Favorite",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserList()));
                          },
                          icon: const AppIcon(
                            icon: Icons.message,
                            iconColor: Colors.deepPurple,
                          ),
                        ),
                        const Text(
                          "Message",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: _toggleLikes,
                          icon: (_isLiked
                              ? const Icon(
                                  Icons.thumb_up,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.thumb_up_alt_outlined,
                                  size: 35,
                                )),
                          color: Colors.blue,
                        ),
                        Text(
                          '${widget.likes}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ]),
            ),

            //  Deco(
            // height: 90,
            // width: 500,
            // horizontal: 30,
            // vertical: 10,

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: 500,
              height: 90,
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
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.location}, Ethiopia",
                        style: const TextStyle(
                            fontSize: 17, overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("at ${widget.company}")
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const VerticalDivider(),
                  Text("${widget.area} sq ft.")
                ],
              ),
            ),

            //  Deco(
            //       height: 90,
            //       width: 500,
            //       horizontal: 30,
            //       vertical: 10,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: 500,
              height: 90,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Birr ${widget.price}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  const VerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.status,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Status")
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              padding: const EdgeInsets.only(top: 5),
              width: 500,
              height: 200,
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
              child: Column(children: [
                const Text(
                  "Overview ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Table(
                    border: TableBorder.all(
                        width: 1, color: Colors.black45), //table border
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Row(
                          children: [
                            const AppIcon(
                              icon: Icons.bed_outlined,
                              iconColor: Colors.deepPurple,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${widget.bedroom} Bedroom")
                          ],
                        )),
                        TableCell(
                            child: Row(
                          children: [
                            const AppIcon(
                              icon: Icons.bathroom_outlined,
                              iconColor: Colors.deepPurple,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${widget.bathRoom} Bathroom")
                          ],
                        )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Row(
                          children: [
                            const AppIcon(
                              icon: Icons.favorite,
                              iconColor: Colors.deepPurple,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${widget.likes} Likes")
                          ],
                        )),
                        TableCell(
                            child: Row(
                          children: [
                            const AppIcon(
                              icon: Icons.date_range_rounded,
                              iconColor: Colors.deepPurple,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.dateAdded)
                          ],
                        )),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
            SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 500,
                height: 300,
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
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Descreption",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.description)
                      ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: 500,
              height: 320,
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
              child: GridView.builder(
                itemCount: widget.image.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => PhotoScreen(
                                  image: widget.image[index],
                                )),
                          ),
                        );
                      },
                      child: Image.network(
                        widget.image[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: 500,
              height: 150,
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
              child: Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.network(
                    widget.ownerImage,
                    width: 100,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Owner's Detail",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.company,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                          Text("${widget.location},Ethiopia"),
                        ],
                      ),
                      Text(
                        widget.email,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoScreen extends StatelessWidget {
  PhotoScreen({super.key, required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
              tag: 'imageHero',
              child: CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, imageProvider) => PhotoView(
                  imageProvider: imageProvider,
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
