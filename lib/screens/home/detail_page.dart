
import 'package:final_project/screens/chat/user_list_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';




class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tsehay real estate',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: appbarColor,
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
              child: Image.asset(
                "assets/house1.jpg",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 90),
              width: 500,
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
                          onPressed: () {},
                          icon: const AppIcon(
                            icon: Icons.favorite,
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
                            icon: Icons.messenger,
                            iconColor: Colors.deepPurple,
                          ),
                        ),
                        const Text(
                          "Message",
                          style: TextStyle(fontSize: 10),
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
                    children: const [
                      Text(
                        "Addis Ababa, Ethiopia",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("at Tsehay Real State")
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const VerticalDivider(),
                  const Text("1000 sq ft.")
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
                    children: const [
                      Text(
                        "Birr 40,000",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Rent per month")
                    ],
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  const VerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Fully Furnished",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Furnishing status")
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
                          children: const [
                            AppIcon(
                              icon: Icons.bed_outlined,
                              iconColor: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("4 Bedroom")
                          ],
                        )),
                        TableCell(
                            child: Row(
                          children: const [
                            AppIcon(
                              icon: Icons.bathroom_outlined,
                              iconColor: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("4 Bathroom")
                          ],
                        )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Row(
                          children: const [
                            AppIcon(
                              icon: Icons.favorite,
                              iconColor: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("260 Likes")
                          ],
                        )),
                        TableCell(
                            child: Row(
                          children: const [
                            AppIcon(
                              icon: Icons.date_range_rounded,
                              iconColor: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("23/5/2023")
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
                    children: const [
                      Text(
                        "Descreption",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "In the same way that there are words that help your home sell faster or for more money, there are definitely some terms you’ll want to steer clear of. Unless you are truly selling your home as a fixer-upper or a flip, avoid these nine real estate marketing words: “Fixer,” “TLC” (as in the home needs some TLC), “cosmetic,” “investment,” “investor,” “potential,” “bargain,” “opportunity” and “nice.” While “nice” is a positive word, it can be highly subjective. Instead of saying you have an “older home in need of TLC,” say something like “A classic abode that can be customized to your liking.”")
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: 500,
              height: 170,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      " @Tsehay Real State",
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Addiss Ababa, Ethiopia"),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Around Ayat"),
                    SizedBox(
                      height: 3,
                    ),
                    Text("building number=7"),
                    SizedBox(
                      height: 3,
                    ),
                    Text("home number=10")
                  ],
                ),
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
                  child: Image.asset(
                    "assets/profile1.jpg",
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
                      const Text(
                        "Tsehay Real State",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                          Text("Addiss Ababa,Ethiopia"),
                        ],
                      ),
                      const Text(
                        "tsehayrealstate@gmail.com",
                        style: TextStyle(color: Colors.grey),
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
