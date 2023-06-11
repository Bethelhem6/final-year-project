import 'package:final_project/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../provider/whishlist_provider.dart';
import '../utils/colors.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final whishlistProvider = Provider.of<WhishlistProvider>(context);

    var box = Hive.box<Whishlist>("wishlist_houses");

    Future<void> showDialogues(
      BuildContext context,
    ) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content: const Text(
                  "All the items will be delete! Do you want to continue?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                TextButton(
                  onPressed: () {
                    whishlistProvider.clearWish();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          });
    }

    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Whishlist> box, _) {
          List<Whishlist> wishlist = box.values.toList().cast<Whishlist>();

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Favourite",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () async {
                        await showDialogues(
                          context,
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red[50],
                        size: 30,
                      )),
                )
              ],
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
            body: wishlist.isEmpty
                ? SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 105.0),
                          child: const Image(
                            image: AssetImage("assets/empty_whish.png"),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 105, top: 20, bottom: 20),
                            child: Text(
                              "Empty Wishlist!",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 105),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            onPressed: () {
                              // Navigator.pop(c/ontext);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPage(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "Add Some",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: wishlist.length,
                        itemBuilder: (context, index) {
                          return favCard(
                              wishlist[index].image,
                              wishlist[index].id,
                              wishlist[index].price,
                              wishlist[index].title,
                              whishlistProvider);
                        }),
                  ),
          );
        });
  }

  Widget favCard(List image, String company, int price, String id,
          WhishlistProvider whishlistProvider) =>
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 600,
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
                  child: Image.network(
                    image[0],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 16,
                  left: 16,
                  child: Text(company,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(12),
                  //   child: Container(
                  //     width: 100,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         color: Colors.deepPurple,
                  //         borderRadius: BorderRadius.circular(15)),
                  //     child: const Center(
                  //       child: Text(
                  //         'Detail',
                  //         style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () {
                        whishlistProvider.removeItem(id);
                      },
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
