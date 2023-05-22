import 'package:final_project/utils/colors.dart';
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
          backgroundColor: appbarColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 240, 200, 21),
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.today_outlined),
              label: 'Home',
              backgroundColor: appbarColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: appbarColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: 'Chat',
              backgroundColor: appbarColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
              backgroundColor: appbarColor,
            ),
          ],
        ),
      ),
    );
  }
}
