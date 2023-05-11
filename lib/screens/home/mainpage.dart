import 'package:final_project/fav/favourite.dart';
import 'package:final_project/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _screens() {
    return [
      HomePage(),
      const Favourite(),
      const UserList(),
      const user_profile(),
    ];
  }

  // ignore: non_constant_identifier_names
  List<PersistentBottomNavBarItem> NavBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: 'Home',
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.deepPurple[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.favorite,
          ),
          title: 'Favorite',
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.red[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.message,
          ),
          title: 'Message',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blue[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: 'User',
          activeColorPrimary: Colors.orange,
          inactiveColorPrimary: Colors.orange[200]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: PersistentTabView(
        backgroundColor: Colors.grey.shade100,
        context,
        items: NavBarItems(),
        screens: _screens(),
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }
}
