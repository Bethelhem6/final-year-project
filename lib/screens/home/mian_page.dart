import 'package:flutter/material.dart';

import '../../fav/favourite.dart';
import '../chat/user_list_screen.dart';
import '../user_profile/user_profile.dart';
import 'home_page.dart';
// import 'package:flutter/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const Favourite(),
    const UserList(),
    const UserProfile(),
  ];
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to Exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.deepPurple,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          unselectedItemColor: const Color.fromARGB(255, 202, 199, 199),
          selectedItemColor: const Color.fromARGB(255, 69, 0, 230),
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple),
              label: 'Home',

              // backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: 'Favorite',
              // backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.blue,
              ),
              label: 'Chat',

              // backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.orange,
              ),
              label: 'Profile',
              // backgroundColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}
