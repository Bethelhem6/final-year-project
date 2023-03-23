import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Top Trending",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return containerCards();
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Recently Added",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return containerCards();
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Luxury",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return containerCards();
                }),
          ),
        ]),
      ),
    );
  }

  Container containerCards() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/house1.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            textWidget(
                color: colorCurve,
                size: 18,
                title: "Noah Real Estate",
                weight: FontWeight.bold),
            textWidget(
              color: textPrimaryDarkColor,
              size: 15,
              title: "Addis Ababa",
            ),
            textWidget(
              color: colorCurve,
              size: 17,
              title: "Birr 2,0000,000,000",
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            )
          ],
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

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Topia Rentals ",
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        textAlign: TextAlign.center,
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
          child: Icon(
            Icons.search,
            color: textPrimaryLightColor,
            size: 33,
          ),
        )
      ],
    );
  }

  Drawer drawer() {
    return Drawer(
      elevation: 5,
      child: ListView(
        // padding: const EdgeInsets.only(bottom: 10),
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: colorCurveSecondary,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                          backgroundColor: textPrimaryLightColor,
                          radius: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Bethelhem Misgina',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textPrimaryLightColor,
                    ),
                  ),
                  Text(
                    'bettymisg6@gmail.com',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text(
              ' Search property',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const MyOrdersScreen())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text(
              ' My Favorites ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const WhishlistPage())));
              // Navigator.pop(context);
            },
          ),
          const Divider(
            height: 5,
            color: Colors.green,
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text(
              ' Contact Users ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const UserScreen())));
              // Navigator.pop(context);
            },
          ),
          const Divider(
            height: 5,
            color: Colors.green,
          ),
          ListTile(
            leading: const Icon(Icons.groups, color: Colors.orange),
            title: const Text(
              ' About Developers ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => const AboutDevelopers())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_mark, color: Colors.deepPurple),
            title: const Text(
              ' About Company ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => const About())));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: const Text(
              'LogOut',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () async {
              // await FirebaseAuth.instance.signOut();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: ((context) => const Login()),
              //   ),
              // );
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
