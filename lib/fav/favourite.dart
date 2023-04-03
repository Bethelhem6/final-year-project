import 'package:flutter/material.dart';

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
                      onPressed: (){},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      )),
                )
              ],
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.deepPurple,
            ),
            // body: 
    );
  }
}
