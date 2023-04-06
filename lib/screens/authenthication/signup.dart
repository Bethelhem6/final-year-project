import 'dart:io';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../helper/helper.dart';
import '../../services/service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscureText = true;
  bool _isVisible = false;

  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  String name = "";
  String phonenumber = "";
  String image = "";
  String url = "";


  AuthService authService = AuthService();

  File? _image;
  XFile? imgXFile;

  Future _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

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
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 120.0),
                              child: GestureDetector(
                                onTap: () {
                                  _getImage();
                                },
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor:
                                      const Color.fromARGB(255, 170, 138, 207),
                                  backgroundImage: _image == null
                                      ? null
                                      : FileImage(_image!),
                                  child: Icon(
                                    _image == null ? Icons.camera_alt : null,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                labelText: "Full Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  size: 25,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Name Can/'t be Empty";
                                }
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  phonenumber = val;
                                });
                              },
                              validator: (val) {
                                return RegExp(r"^[0-9]").hasMatch(val!)
                                    ? null
                                    : "Please Enter a Valid Phone Number";
                              },
                              keyboardType: TextInputType.number,
                              decoration: textInputDecoration.copyWith(
                                labelText: "Phone Number",
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  size: 25,
                                  color: Colors.deepPurple,
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                                labelText: "E-mail",
                                prefixIcon: const Icon(
                                  Icons.email,
                                  size: 25,
                                  color: Colors.deepPurple,
                                )),
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
                                  : "Please enter a valid email";
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
                          const SizedBox(height: 20),
                          SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: GestureDetector(
                                  onTap: () {
                                    Register();
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
                                      "Sign Up",
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
                              text: "Already have an account? ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Login.",
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextScreen(context, const LoginPage());
                                      }),
                              ])),
                        ],
                      )),
                ),
              ),
      ),
    );
  }
  

  Register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUser(name, email, password, phonenumber, image)
          .then((value) async {
        if (value == true) {
          await Helperfunctions.saveUserLoggedInStatus(true);
          await Helperfunctions.saveUserEmailSF(email);
          await Helperfunctions.saveUserNameSF(name);
          // await Helperfunctions.saveUserNameSF(phonenumber);
          // await Helperfunctions.saveUserNameSF(image);
          nextScreenReplace(context, HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}