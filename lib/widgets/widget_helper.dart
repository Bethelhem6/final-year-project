import 'package:flutter/material.dart';


class NText extends StatelessWidget {
  final String name;

  const NText({
    Key? key,
    required this.name,
    required TextStyle style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: const TextStyle(
            color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final String name;
  final IconData icon;

  final double iconSize;
  final double textSize;
  final Color iconColor;
  final controller;
  final keyboardType;

  Textfield({
    Key? key,
    required this.name,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.iconSize = 25,
    this.textSize = 15,
    this.iconColor = Colors.deepPurple,
  }) : super(key: key);

  final textfield = TextEditingController();
  void clearText() {
    textfield.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(18)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(18)),
          prefixIcon: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          hintText: name,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

// class Emailfield extends StatefulWidget {
//   final String name;
//   final IconData icon;
//   final double iconSize;
//   final double textSize;
//   final Color iconColor;

//   const Emailfield({
//     Key? key,
//     required this.name,
//     required this.icon,
//     this.iconSize = 25,
//     this.textSize = 15,
//     this.iconColor = Colors.deepPurple,
//   }) : super(key: key);

//   @override
//   State<Emailfield> createState() => _EmailfieldState();
// }

// class _EmailfieldState extends State<Emailfield> {
//   final textfield = TextEditingController();
//   final _emailController = TextEditingController();

//   void clearText() {
//     textfield.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: TextField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.white),
//               borderRadius: BorderRadius.circular(18)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.deepPurple),
//               borderRadius: BorderRadius.circular(18)),
//           prefixIcon: Icon(
//             widget.icon,
//             size: widget.iconSize,
//             color: widget.iconColor,
//           ),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               clearText();
//             },
//             child: Icon(
//               Icons.clear,
//               size: widget.iconSize,
//               color: Colors.grey,
//             ),
//           ),
//           hintText: widget.name,
//           fillColor: Colors.grey[200],
//           filled: true,
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//         ),
//       ),
//     );
//   }
// }

// AppBar customeAppBar({required Text title}) {
//   return AppBar(
//     title: title,
//     automaticallyImplyLeading: false,
//     elevation: 0.0,
//     backgroundColor: Colors.deepPurple,
//     flexibleSpace: Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/stg.png'), fit: BoxFit.fill)),
//     ),
//   );
// }

class Textbutton extends StatefulWidget {
  final String text;

  const Textbutton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<Textbutton> createState() => _TextbuttonState();
}

class _TextbuttonState extends State<Textbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          widget.text,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

 InputDecoration textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.deepPurple),
      borderRadius: BorderRadius.circular(18)
      ),
   enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(18)),
  errorBorder:const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}