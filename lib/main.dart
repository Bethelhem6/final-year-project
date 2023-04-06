import 'dart:developer';

import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/screens.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();


  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AR based properties sell and rent',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: appbarColor,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 1,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 19),
              backgroundColor: Colors.white,
            )),
        home: const AuthStateScreen());
  }
}

_initializeFirebase() async {

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}
