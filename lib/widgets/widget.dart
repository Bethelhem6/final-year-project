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

  const Textfield({
    Key? key,
    required this.name,
    required this.icon,
    this.iconSize = 25,
    this.textSize = 15,
    this.iconColor = Colors.deepPurple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
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

AppBar customeAppBar({required Text title}) {
  return AppBar(
    title: title,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    backgroundColor: Colors.deepPurple,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/stg.png'), fit: BoxFit.fill)),
    ),
  );
}

class Textbutton extends StatelessWidget {
  final String text;
  const Textbutton({
    Key? key,
    required this.text,
  }) : super(key: key);

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
          text,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class Passwordfield extends StatefulWidget {
  final String pname;
  final IconData picon;

  final double piconSize;
  final double ptextSize;
  final Color piconColor;

  const Passwordfield({
    Key? key,
    required this.pname,
    required this.picon,
    this.piconSize = 25,
    this.ptextSize = 15,
    this.piconColor = Colors.deepPurple,
  }) : super(key: key);

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  bool obscureText = true;
  bool _isVisible = false;
  String _password = '';

  get iconColor => null;

  get iconSize => null;

  IconData? get picon => null;

  get name => null;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
            prefixIcon: Icon(
              picon,
              size: iconSize,
              color: iconColor,
            ),
            hintText: name,
            fillColor: Colors.grey[200],
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: _isVisible
                ? GestureDetector(
                    child: obscureText
                        ? Container(
                            width: 25,
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.visibility,
                              color: Colors.deepPurple,
                            ),
                          )
                        : Container(
                            width: 25,
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.visibility_off,
                              color: Colors.deepPurple,
                            ),
                          ),
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null),
        obscureText: _isVisible ? obscureText : true,
        onChanged: (enteredPassword) {
          _password = enteredPassword;
          if (enteredPassword.isEmpty) {
            setState(() {
              _isVisible = false;
            });
          } else {
            if (!_isVisible) {
              setState(() {
                _isVisible = !_isVisible;
              });
            }
          }
        },
      ),
    );
  }
}