// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_project/screens/home/view_more.dart';
import 'package:final_project/screens/review/review_page.dart';
import 'package:final_project/screens/search/filter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../fav/favourite.dart';
import '../../utils/colors.dart';
import '../developers/developers.dart';
import '../screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController =
      PageController(viewportFraction: 0.75, initialPage: 2);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  double offset = 0.0;
  var _currentPage = 0.0;

  XFile? imgXFile;

  String _uid = "";
  String _name = "";
  String _email = "";
  String _image = "";

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    setState(() {
      _name = userDocs.get('name');
      _email = userDocs.get('email');
      _image = userDocs.get('image');
    });
  }

   logoutMessage() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to Logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  User? user = _auth.currentUser;
                  _uid = user!.uid;
                  await _auth.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();

    // _pageController = PageController(initialPage: 2);
    _scrollController = ScrollController();
    _scrollController.addListener(swapPageListener);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    _getData();
  }

  void swapPageListener() {
    offset = _scrollController.offset;
    setState(() {
      _pageController.hasClients;
      if (offset > _scrollController.position.maxScrollExtent + 100) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceIn);
      }
      if (offset < _scrollController.position.minScrollExtent - 100) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  "Available houses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const ViewMore(
                                collection: "houses",
                              )),
                        ));
                  },
                  child: Text(
                    "View more",
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          FadeInUp(
            delay: const Duration(milliseconds: 550),
            child: Container(
              margin: const EdgeInsets.all(20),
              width: size.width,
              height: size.height * 0.45,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection("houses").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    var doc = snapshot.data!.docs;

                    return PageView.builder(
                        controller: _pageController,
                        itemCount: doc.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: view(index, textTheme, size));
                        });
                  }
                  return Container();
                },
              ),
            ),
          ),
          DotsIndicator(
            dotsCount: 5,
            position: _currentPage,
            decorator: const DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: Colors.deepPurple,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Available for sell",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const ViewMore(
                                collection: "houses",
                                whatFor: "Sell",
                              )),
                        ));
                  },
                  child: Text(
                    "View more",
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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

                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          return containerCards(doc[index]);
                        }),
                  );
                }
                return Container();
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Available for rent",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ViewMore(
                            collection: "houses", whatFor: "Rent")),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20),
                  child: Text(
                    "View more",
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("houses")
                  .where("whatFor", isEqualTo: "Rent")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  var doc = snapshot.data!.docs;

                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          return containerCards(doc[index]);
                        }),
                  );
                }
                return Container();
              }),
        ]),
      ),
    );
  }

//cards for containers
  Container containerCards(var doc) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          String location = "";
          String company = '';
          String status = '';
          String description = '';
          int price = 0;
          int bedroom = 0;
          int bathRoom = 0;
          int likes = 0;
          String id = "";
          int area = 0;
          String dateAdded = "";
          List imageUrl = [];
          String name = "";
          String email = "";
          String ownerImage = "";

          setState(() {
            location = doc["address"];
            bedroom = doc["bedRoom"];
            likes = doc["likes"];
            bedroom = doc["bedRoom"];
            name = doc['ownerName'];
            email = doc['ownerEmail'];
            bathRoom = doc["bathRoom"];
            company = doc['companyName'];
            description = doc['description'];
            location = doc['address'];
            price = doc['price'];
            status = doc['status'];
            dateAdded = doc['dateAdded'];
            imageUrl = doc['imageUrls'];
            ownerImage = doc['ownerImage'];
            area = doc["area"];
            id = doc["id"];
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
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
                  uid: _uid,
                  id: id,
                ),
              ));
        },
        child: Container(
          // padding: const EdgeInsets.only(left: 20),
          margin: const EdgeInsets.only(left: 10, bottom: 10),
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
          height: 200,
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(doc["imageUrls"][0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              textWidget(
                color: textPrimaryDarkColor,
                size: 15,
                title: doc['address'],
              ),
              textWidget(
                color: appbarColor,
                size: 17,
                title: "Birr ${doc['price'].toString()}",
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding textWidget(
      {required String title,
      required Color color,
      required double size,
      FontWeight? weight}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: Text(
        title,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: size,
          fontWeight: weight,
        ),
      ),
    );
  }

  /// Page View
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0.0;
          if (_pageController.position.haveDimensions) {
            value = index.toDouble() - (_pageController.page ?? 0);
            value = (value * 0.04).clamp(-2, 2);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection("houses").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    var doc = snapshot.data!.docs;

                    return card(doc[index], theme, size);
                  }

                  return Container();
                }),
          );
        });
  }

  /// Page view Cards
  Widget card(QueryDocumentSnapshot<Map<String, dynamic>> data, TextTheme theme,
      Size size) {
    String location = "";
    String company = '';
    String status = '';
    String description = '';
    int price = 0;
    int bedroom = 0;
    int bathRoom = 0;
    int likes = 0;
    String dateAdded = "";
    String name = "";
    String email = "";
    String ownerImage = "";
    int area = 0;
    List image = [];
    String id = "";
    return GestureDetector(
      onTap: () {
        setState(() {
          location = data["address"];
          bedroom = data["bedRoom"];
          likes = data["likes"];
          bathRoom = data["bathRoom"];
          company = data['companyName'];
          description = data['description'];
          location = data['address'];
          price = data['price'];
          status = data['status'];
          dateAdded = data['dateAdded'];
          image = data['imageUrls'];
          name = data['ownerName'];
          email = data['ownerEmail'];
          ownerImage = data['ownerImage'];
          area = data["area"];
          id = data['id'];
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    uid: _uid,
                    bathRoom: bathRoom,
                    bedroom: bedroom,
                    company: company,
                    description: description,
                    location: location,
                    price: price,
                    status: status,
                    likes: likes,
                    dateAdded: dateAdded,
                    image: image,
                    name: name,
                    email: email,
                    ownerImage: ownerImage,
                    area: area,
                    id: id,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Stack(
          children: [
            Hero(
              tag: data.id,
              child: Container(
                width: 270,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.deepPurple[100],
                  image: DecorationImage(
                    image: NetworkImage(data["imageUrls"][0]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(61, 0, 0, 0))
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 45,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    textWidget(
                        title: data["address"],
                        color: Colors.grey.shade700,
                        size: 15,
                        weight: FontWeight.normal),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 45,
              child: textWidget(
                  title: "Birr ${data["price"]}",
                  color: appbarColor,
                  size: 18,
                  weight: FontWeight.bold),
            ),
            Positioned(
                top: 10,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(10),
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
                    "For ${data['whatFor']}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    // final user = FirebaseAuth.instance.currentUser!;

    return AppBar(
      backgroundColor: appbarColor,
      title: Column(
        children: [
          const Text(
            "Topia Rentals ",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(
              "Hello 👋, $_name...",
              style: TextStyle(fontSize: 18, color: Colors.grey.shade300),
            ),
          ),
        ],
      ),
      toolbarHeight: 100,
      toolbarOpacity: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0, left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SearchHouse())));
            },
            icon: Icon(
              Icons.search,
              color: textPrimaryLightColor,
              size: 33,
            ),
          ),
        )
      ],
    );
  }

//drawer
  Drawer drawer() {
    return Drawer(
      elevation: 5,
      child: ListView(
        // padding: const EdgeInsets.only(bottom: 10),
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                          // backgroundColor: textPrimaryLightColor,
                          backgroundImage: NetworkImage(_image),
                          radius: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _name,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textPrimaryLightColor,
                    ),
                  ),
                  Text(
                    _email,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text(
              ' My Favorites ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Favourite())));
              // Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text(
              ' My Profile ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const UserProfile())));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.message, color: Colors.pink),
            title: const Text(
              ' Contact Users ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const UserList())));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.orange),
            title: const Text(
              ' Rate and Review ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ReviewPage())));
              // Navigator.pop(context);
            },
          ),
          const Divider(
            height: 5,
            color: Colors.deepPurple,
          ),
          ListTile(
            leading: const Icon(Icons.code, color: Colors.blueGrey),
            title: const Text(
              ' About Developers ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AboutDevelopers())));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: GestureDetector(
              onTap: logoutMessage
              // () async {
              //   await FirebaseAuth.instance.signOut();
              //   Navigator.pop(context);

              //   Navigator.pop(context);
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()));
              // }
              ,
              child: const Text(
                'LogOut',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
