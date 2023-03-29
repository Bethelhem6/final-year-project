import 'package:animate_do/animate_do.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_project/screens/chat/chat.dart';
import 'package:final_project/screens/search/search_result_page.dart';
import 'package:flutter/material.dart';

import '../../models/base_model.dart';
import '../../utils/colors.dart';
import '../../models/app_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController =
      PageController(viewportFraction: 0.75, initialPage: 2);

  late ScrollController _scrollController;
  double offset = 0.0;
  var _currentPage = 2.0;

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
                  "Available for sell",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
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
            ],
          ),
          FadeInUp(
            delay: const Duration(milliseconds: 550),
            child: Container(
              margin: const EdgeInsets.all(20),
              width: size.width,
              height: size.height * 0.45,
              child: PageView.builder(
                controller: _pageController,
                itemCount: categories.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(child: view(index, textTheme, size));
                },
              ),
            ),
          ),
          DotsIndicator(
            dotsCount: categories.length,
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
                  "Recently Added",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
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
            ],
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
                onTap: () {},
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

//cards for containers
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
                  image: AssetImage("assets/house1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            textWidget(
              color: textPrimaryDarkColor,
              size: 15,
              title: "Addis Ababa",
            ),
            textWidget(
              color: appbarColor,
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
            child: card(mainList[index], theme, size),
          );
        });
  }

  /// Page view Cards
  Widget card(BaseModel data, TextTheme theme, Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              width: 270,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                image: DecorationImage(
                  image: AssetImage(data.imageUrl),
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
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                ),
                textWidget(
                    title: "Addis Ababa",
                    color: Colors.grey.shade700,
                    size: 15,
                    weight: FontWeight.normal),
              ],
            ),
          ),
          textWidget(
              title: "Birr 400,000,000",
              color: appbarColor,
              size: 18,
              weight: FontWeight.bold),
        ],
      ),
    );
  }

  AppBar appBar() {
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
              "Hello 👋, Bethelhem...",
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
                    builder: (context) => SearchResult(),
                  ));
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
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.blue),
            title: const Text(
              ' Search property',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const WhishlistPage())));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.groups, color: Colors.orange),
            title: const Text(
              ' Contact Users ',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>  ChatPage())));
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
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => const AboutDevelopers())));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: const Text(
              'LogOut',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
