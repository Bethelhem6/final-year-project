import 'dart:developer';

import 'package:final_project/provider/whishlist_provider.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  LocalNotificationService.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(WhishlistAdapter());
  await Hive.openBox<Whishlist>('wishlist_houses');

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
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (ctx) => WhishlistProvider()),
      ],
      child: MaterialApp(
          title: 'AR based properties sell and rent',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            indicatorColor: buttonColor,
            primaryColor: appbarColor,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                circularTrackColor: Colors.deepPurple, color: Colors.grey),
            
          ),
          home: const AuthStateScreen()),
    );
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
