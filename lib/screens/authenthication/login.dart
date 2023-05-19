// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:final_project/services/service.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  bool _isVisible = false;

  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              labelText: "E-mail",
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.deepPurple,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please Enter a Valid E-mail";
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: 'Password',
                                fillColor: Colors.grey[200],
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                suffixIcon: _isVisible
                                    ? GestureDetector(
                                        child: obscureText
                                            ? Container(
                                                width: 25,
                                                height: 25,
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                            onChanged: (val) {
                              password = val;
                              if (val.isEmpty) {
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
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ResetPassword()));
                                    },
                                    child: const Text("forget password?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: GestureDetector(
                                  onTap: () {
                                    Login();
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Center(
                                        child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          Text.rich(TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " Sign Up.",
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextScreen(
                                            context, const RegisterPage());
                                      }),
                              ])),
                        ],
                      )),
                ),
              ));
  }

  Login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      formkey.currentState!.save();

      try {

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const MainPage()),
        );
      } catch (e) {
        if (mounted) {
          showSnackbar(context, Colors.red, e.toString());
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
      // await authService.loginUser(email, password).then((value) async {
      //   if (value == true) {
      //     QuerySnapshot snapshot =
      //         await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      //             .gettingUserData(email);

      //     // saving the values to our shared preferences
      //     await Helperfunctions.saveUserLoggedInStatus(true);
      //     await Helperfunctions.saveUserEmailSF(email);
      //     // await Helperfunctions.saveUserNameSF(snapshot.docs[0]['fullname']);
      //     nextScreenReplace(context, MainPage());
      //   } else {
      //     showSnackbar(context, Colors.red, value);
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   }
      // });
    }
  }
}
