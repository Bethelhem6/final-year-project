import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDarkTheme
            ? const Color.fromARGB(255, 20, 20, 20)
            : const Color.fromARGB(255, 103, 58, 183),
      ),
      // bottomSheetTheme: BottomSheetThemeData(
      //   backgroundColor: isDarkTheme
      //       ? const Color.fromARGB(255, 20, 20, 20)
      //       : const Color.fromARGB(255, 103, 58, 183),
      // ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        
        backgroundColor: isDarkTheme
            ? const Color.fromARGB(255, 3, 3, 3)
            : const Color.fromARGB(255, 103, 58, 183),
      ),
      dividerColor: isDarkTheme
          ? const Color.fromARGB(255, 250, 250, 250)
          : const Color.fromARGB(255, 103, 58, 183),
      cardTheme: CardTheme(
        color: isDarkTheme
            ? const Color.fromARGB(255, 20, 20, 20)
            : const Color.fromARGB(255, 255, 255, 255),
      ),
      drawerTheme: DrawerThemeData(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 3, 3, 3)
              : const Color.fromARGB(255, 242, 241, 243)),
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white),
          color: isDarkTheme
              ? const Color.fromARGB(255, 3, 3, 3)
              : const Color.fromARGB(255, 103, 58, 183)),
      scaffoldBackgroundColor:
          //0A1931  // white yellow 0xFFFCF8EC
          isDarkTheme
              ? const Color.fromARGB(255, 24, 24, 24)
              : const Color(0xFFFFFFFF),
      primaryColor:
          isDarkTheme ? Colors.black : const Color.fromARGB(255, 103, 58, 183),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color(0xFFE8FDFD),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}
