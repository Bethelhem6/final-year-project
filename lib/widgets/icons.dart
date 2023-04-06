import 'package:flutter/material.dart';


class AppIcon extends StatelessWidget {
   final IconData icon;
  final Color iconColor;
  final double size;
  final double iconSize;
    const AppIcon({
    Key?key,
    required this.icon,
    this.iconColor:const Color.fromARGB(255, 255, 255, 255),
    this.size=50,
    this.iconSize=35,
        })
   : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
         ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}