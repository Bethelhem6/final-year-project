import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  setPage(context),
                  const Positioned(
                    top: 280,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Top Trending",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 245,
                    width: MediaQuery.of(context).size.width,
                    top: 340,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return containerCards();
                        }),
                  ),
                  const Positioned(
                    top: 560,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Recently Added",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 245,
                    width: MediaQuery.of(context).size.width,
                    top: 620,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return containerCards();
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Container containerCards() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        // padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.only(left: 10, bottom: 20),
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

  Widget setPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          // Background
          color: colorCurve,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          // Background
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: const EdgeInsets.fromLTRB(1, 1, 0, 0),
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  // drawer();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Which type of house",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "are you looking for?",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorCurveSecondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(130),
                bottomRight: Radius.circular(130),
              ),
            ),
          ),
        ),

        Container(), // Required some widget in between to float AppBar

        appBarCard(),
      ],
    );
  }

  Positioned appBarCard() {
    return Positioned(
        // To take AppBar Size only
        top: 80.0,
        left: 20.0,
        right: 20.0,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                AppBar(
                  backgroundColor: Colors.white,
                  leading: Icon(Icons.search, color: colorCurve),
                  primary: false,
                  title: const TextField(
                      decoration: InputDecoration(
                          hintText: "Search by city/region...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Top cities:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          // height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Addis Ababa",
                              style: TextStyle(
                                  color: textPrimaryDarkColor, fontSize: 13),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ));
  }
}
