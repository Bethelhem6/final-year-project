// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:we_chat/api/apis.dart';
// import 'package:we_chat/screens/chat/auth/login_screen.dart';
// import 'package:we_chat/screens/chat/home_screen.dart';

// import '../../../helper/dialogs.dart';
// import 'auth_service.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   bool _isLoading = false;
//   final formKey = GlobalKey<FormState>();
//   String email = "";
//   String password = "";
//   String fullName = "";
//   AuthService authService = AuthService();

//   get HelperFunctions => null;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//                   color: Theme.of(context).primaryColor))
//           : SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
//                 child: Form(
//                     key: formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         const Text(
//                           "Groupie",
//                           style: TextStyle(
//                               fontSize: 40, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                             "Create your account now to chat and explore",
//                             style: TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.w400)),
//                         // Image.asset("assets/register.png"),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               labelText: "Full Name",
//                               prefixIcon: Icon(
//                                 Icons.person,
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                           onChanged: (val) {
//                             setState(() {
//                               fullName = val;
//                             });
//                           },
//                           validator: (val) {
//                             if (val!.isNotEmpty) {
//                               return null;
//                             } else {
//                               return "Name cannot be empty";
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               labelText: "Email",
//                               prefixIcon: Icon(
//                                 Icons.email,
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                           onChanged: (val) {
//                             setState(() {
//                               email = val;
//                             });
//                           },

//                           // check tha validation
//                           validator: (val) {
//                             return RegExp(
//                                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                     .hasMatch(val!)
//                                 ? null
//                                 : "Please enter a valid email";
//                           },
//                         ),
//                         const SizedBox(height: 15),
//                         TextFormField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                               labelText: "Password",
//                               prefixIcon: Icon(
//                                 Icons.lock,
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                           validator: (val) {
//                             if (val!.length < 6) {
//                               return "Password must be at least 6 characters";
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (val) {
//                             setState(() {
//                               password = val;
//                             });
//                           },
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 primary: Theme.of(context).primaryColor,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30))),
//                             child: const Text(
//                               "Register",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16),
//                             ),
//                             onPressed: () {
//                               _handleGoogleBtnClick();
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text.rich(TextSpan(
//                           text: "Already have an account? ",
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 14),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: "Login now",
//                                 style: const TextStyle(
//                                     color: Colors.black,
//                                     decoration: TextDecoration.underline),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 LoginScreen()));
//                                   }),
//                           ],
//                         )),
//                       ],
//                     )),
//               ),
//             ),
//     );
//   }

//   register() async {
//     if (formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       await authService
//           .registerUserWithEmailandPassword(fullName, email, password);
//         //   .then((value) async {
//         // // APIs.createUser();
//         // if (value == true) {
//         //   // saving the shared preference state
//         //   await HelperFunctions.saveUserLoggedInStatus(true);
//         //   await HelperFunctions.saveUserEmailSF(email);
//         //   await HelperFunctions.saveUserNameSF(fullName);
//         //   // Navigator.push(
//         //   //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         // } else {
//         //   // /showSnackbar(context, Colors.red, value);
//           setState(() {
//             _isLoading = false;
//           });
//         // }
//       // });
//     }
//   }
//    _handleGoogleBtnClick() {
//     //for showing progress bar
//     Dialogs.showProgressBar(context);

//     register().then((user) async {
//       //for hiding progress bar
//       Navigator.pop(context);

//       if (user != null) {
       
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
// }
