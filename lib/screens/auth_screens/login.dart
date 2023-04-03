import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../screens.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  bool _isVisible = false;

  String _password = '';
  String _email = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showErrorMessage(e.code);
    }
    Navigator.of(context).pop();
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 192, 175, 219),
          title: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 350,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            flexibleSpace: ClipPath(
              clipper: Customeshape(),
              child: Container(
                height: 360,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 200, 185, 224),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 120, 40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 180,
                      color: Colors.deepPurple,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.home_rounded, color: Colors.deepPurple),
                        Icon(Icons.home_rounded),
                        Icon(Icons.home_rounded, color: Colors.deepPurple),
                        Icon(Icons.home_rounded),
                        Icon(Icons.home_rounded, color: Colors.deepPurple),
                        Icon(Icons.home_rounded),
                        Icon(Icons.home_rounded, color: Colors.deepPurple),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // onChanged: (val){ _email= val;},
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(18)),
                      prefixIcon: const Icon(
                        Icons.email,
                        size: 25,
                        color: Colors.deepPurple,
                      ),
                      hintText: "E-mail",
                      fillColor: Colors.grey[200],
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
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
                      // enteredPassword= _password;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassPage()));
                      },
                      child: const Text('forget password?',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: signIn,
                  // () async { 
                  // print(_email);
                  // print(_password);
                  // },
                  child: const Textbutton(
                    text: 'Login',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Dont have an account?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    child: const Text('  Sign Up.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
              ],
            ),
          )),
    );
  }
}
