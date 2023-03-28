import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../screens.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();

  bool obscureText = true;
  bool _encryptPassword = true;
  bool _isVisible = false;
  bool showEye = false;
  String _password = '';

  signUp() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 199,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            shadowColor: const Color.fromARGB(255, 188, 176, 209),
            flexibleSpace: ClipPath(
              clipper: Customeshape(),
              child: Container(
                height: 210,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 200, 185, 224),
                      Color.fromARGB(255, 200, 185, 224),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 150, 90),
                child: Icon(
                  Icons.home_work_outlined,
                  size: 120,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Please fill in the detail information to create an account.',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Textfield(
                    icon: Icons.person,
                    name: "First Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Textfield(
                    icon: Icons.person,
                    name: "Last Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Textfield(
                    icon: Icons.phone_outlined,
                    name: "Phone Number",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Textfield(
                    icon: Icons.email,
                    name: "E-mail",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      // controller: _passwordController,
                      // onChanged: (value) {},
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          hintText: 'Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: _isVisible
                              ? GestureDetector(
                                  child: obscureText
                                      ? Container(
                                          width: 25,
                                          height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.visibility,
                                            color: Colors.deepPurple,
                                          ),
                                        )
                                      : Container(
                                          width: 25,
                                          height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // confirm password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      // controller: _passwordController,
                      // onChanged: (value) {},
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          hintText: 'Confirm Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: showEye
                              ? GestureDetector(
                                  child: _encryptPassword
                                      ? Container(
                                          width: 25,
                                          height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.visibility,
                                            color: Colors.deepPurple,
                                          ),
                                        )
                                      : Container(
                                          width: 25,
                                          height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.visibility_off,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                  onTap: () {
                                    setState(() {
                                      _encryptPassword = !_encryptPassword;
                                    });
                                  },
                                )
                              : null),
                      obscureText: showEye ? _encryptPassword : true,
                      onChanged: (enteredPassword) {
                        _password = enteredPassword;
                        if (enteredPassword.isEmpty) {
                          setState(() {
                            showEye = false;
                          });
                        } else {
                          if (!showEye) {
                            setState(() {
                              showEye = !showEye;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: const Textbutton(
                      text: 'Sign Up',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Already have an account.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text('  Log in.',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                    )
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
