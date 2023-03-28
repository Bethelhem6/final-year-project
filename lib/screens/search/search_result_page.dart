import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade400,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  child: const Text(
                    "Topia Rentals ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  // To take AppBar Size only
                  top: 60.0,
                  left: 20.0,
                  right: 20.0,
                  child: Card(
                    elevation: 15,
                    color: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
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
                                    hintText: "Customize your search..",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // height: 800,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return resultCard();
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Stack resultCard() {
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
              const SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "250 \nsq.ft",
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
                      "2 Bedrooms \nin A.A",
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
                      "Birr 5000/\nmonth",
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
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50 / 2),
                color: backgroundColor),
            child: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.red,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
