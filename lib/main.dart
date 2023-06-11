import 'dart:developer';

import 'package:final_project/provider/whishlist_provider.dart';
import 'package:final_project/services/dark_theme_provider.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/theme_data.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => WhishlistProvider()),
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            title: 'AR based properties sell and rent',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            // theme: ThemeData(
            //   indicatorColor: buttonColor,
            //   primaryColor: appbarColor,
            //   primarySwatch: Colors.deepPurple,
            //   progressIndicatorTheme: const ProgressIndicatorThemeData(
            //       circularTrackColor: Colors.deepPurple, color: Colors.grey),
            // ),
            home: const AuthStateScreen());
      }),
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
