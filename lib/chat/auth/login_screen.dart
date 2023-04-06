// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/gestures.dart';
// // import 'package:flutter/material.dart';
// // import 'package:we_chat/screens/auth/register.dart';

// // import 'auth_service.dart';
// // import 'dataservice.dart';
// // import 'helper.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final formKey = GlobalKey<FormState>();
// //   String email = "";
// //   String password = "";
// //   bool _isLoading = false;
// //   AuthService authService = AuthService();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _isLoading
// //           ? Center(
// //               child: CircularProgressIndicator(
// //                   color: Theme.of(context).primaryColor),
// //             )
// //           : SingleChildScrollView(
// //               child: Padding(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
// //                 child: Form(
// //                     key: formKey,
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: <Widget>[
// //                         const Text(
// //                           "Groupie",
// //                           style: TextStyle(
// //                               fontSize: 40, fontWeight: FontWeight.bold),
// //                         ),
// //                         const SizedBox(height: 10),
// //                         const Text("Login now to see what they are talking!",
// //                             style: TextStyle(
// //                                 fontSize: 15, fontWeight: FontWeight.w400)),
// //                         // Image.asset("assets/login.png"),
// //                         TextFormField(
// //                           decoration: InputDecoration(
// //                               labelText: "Email",
// //                               prefixIcon: Icon(
// //                                 Icons.email,
// //                                 color: Theme.of(context).primaryColor,
// //                               )),
// //                           onChanged: (val) {
// //                             setState(() {
// //                               email = val;
// //                             });
// //                           },

// //                           // check tha validation
// //                           validator: (val) {
// //                             return RegExp(
// //                                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
// //                                     .hasMatch(val!)
// //                                 ? null
// //                                 : "Please enter a valid email";
// //                           },
// //                         ),
// //                         const SizedBox(height: 15),
// //                         TextFormField(
// //                           obscureText: true,
// //                           decoration: InputDecoration(
// //                               labelText: "Password",
// //                               prefixIcon: Icon(
// //                                 Icons.lock,
// //                                 color: Theme.of(context).primaryColor,
// //                               )),
// //                           validator: (val) {
// //                             if (val!.length < 6) {
// //                               return "Password must be at least 6 characters";
// //                             } else {
// //                               return null;
// //                             }
// //                           },
// //                           onChanged: (val) {
// //                             setState(() {
// //                               password = val;
// //                             });
// //                           },
// //                         ),
// //                         const SizedBox(
// //                           height: 20,
// //                         ),
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                                 primary: Theme.of(context).primaryColor,
// //                                 elevation: 0,
// //                                 shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(30))),
// //                             child: const Text(
// //                               "Sign In",
// //                               style:
// //                                   TextStyle(color: Colors.white, fontSize: 16),
// //                             ),
// //                             onPressed: () {
// //                               login();
// //                             },
// //                           ),
// //                         ),
// //                         const SizedBox(
// //                           height: 10,
// //                         ),
// //                         Text.rich(TextSpan(
// //                           text: "Don't have an account? ",
// //                           style: const TextStyle(
// //                               color: Colors.black, fontSize: 14),
// //                           children: <TextSpan>[
// //                             TextSpan(
// //                                 text: "Register here",
// //                                 style: const TextStyle(
// //                                     color: Colors.black,
// //                                     decoration: TextDecoration.underline),
// //                                 recognizer: TapGestureRecognizer()
// //                                   ..onTap = () {
// //                                     Navigator.push(
// //                                         context,
// //                                         MaterialPageRoute(
// //                                             builder: (context) =>
// //                                                 RegisterPage()));
// //                                   }),
// //                           ],
// //                         )),
// //                       ],
// //                     )),
// //               ),
// //             ),
// //     );
// //   }

// //   login() async {
// //     if (formKey.currentState!.validate()) {
// //       setState(() {
// //         _isLoading = true;
// //       });
// //       await authService
// //           .loginWithUserNameandPassword(email, password)
// //           .then((value) async {
// //         if (value == true) {
// //           QuerySnapshot snapshot =
// //               await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
// //                   .gettingUserData(email);
// //           // saving the values to our shared preferences
// //           await HelperFunctions.saveUserLoggedInStatus(true);
// //           await HelperFunctions.saveUserEmailSF(email);
// //           await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
// //           print("logged in");
// //           // nextScreenReplace(context, const HomeScreen());
// //         } else {
// //           // showSnackbar(context, Colors.red, value);
// //           setState(() {
// //             _isLoading = false;
// //           });
// //         }
// //       });
// //     }
// //   }
// // }
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../../../api/apis.dart';
// import '../../../helper/dialogs.dart';
// import '../../../main.dart';
// import '../home_screen.dart';

// //login screen -- implements google sign in or sign up feature for app
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isAnimate = false;

//   @override
//   void initState() {
//     super.initState();

//     //for auto triggering animation
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() => _isAnimate = true);
//     });
//   }

//   // handles google login button click
//   _handleGoogleBtnClick() {
//     //for showing progress bar
//     Dialogs.showProgressBar(context);

//     _signInWithGoogle().then((user) async {
//       //for hiding progress bar
//       Navigator.pop(context);

//       if (user != null) {
//         log('\nUser: ${user.user}');
//         log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

//         if ((await APIs.userExists())) {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//         } else {
//           await APIs.createUser().then((value) {
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//           });
//         }
//       }
//     });
//   }

//   Future<UserCredential?> _signInWithGoogle() async {
//     try {
//       await InternetAddress.lookup('google.com');
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       // Once signed in, return the UserCredential
//       return await APIs.auth.signInWithCredential(credential);
//     } catch (e) {
//       log('\n_signInWithGoogle: $e');
//       Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
//       return null;
//     }
//   }

//   //sign out function
//   // _signOut() async {
//   //   await FirebaseAuth.instance.signOut();
//   //   await GoogleSignIn().signOut();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //initializing media query (for getting device screen size)
//     // mq = MediaQuery.of(context).size;

//     return Scaffold(
//       //app bar
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Welcome to We Chat'),
//       ),

//       //body
//       body: Stack(children: [
//         //app logo
//         AnimatedPositioned(
//             top: mq.height * .15,
//             right: _isAnimate ? mq.width * .25 : -mq.width * .5,
//             width: mq.width * .5,
//             duration: const Duration(seconds: 1),
//             child: Image.asset('images/icon.png')),

//         //google login button
//         Positioned(
//             bottom: mq.height * .15,
//             left: mq.width * .05,
//             width: mq.width * .9,
//             height: mq.height * .06,
//             child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 223, 255, 187),
//                     shape: const StadiumBorder(),
//                     elevation: 1),
//                 onPressed: () {
//                   _handleGoogleBtnClick();
//                 },

//                 //google icon
//                 icon: Image.asset('images/google.png', height: mq.height * .03),

//                 //login with google label
//                 label: RichText(
//                   text: const TextSpan(
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                       children: [
//                         TextSpan(text: 'Login with '),
//                         TextSpan(
//                             text: 'Google',
//                             style: TextStyle(fontWeight: FontWeight.w500)),
//                       ]),
//                 ))),
//       ]),
//     );
//   }
// }