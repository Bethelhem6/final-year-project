// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_final_fields, avoid_print, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:final_project/screens/authenthication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/login';

  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';

  bool _isLoading = false;

  void _submitData() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      try {
        await _auth.sendPasswordResetEmail(email: _email).then((value) =>
            showSnackbar(context, Colors.deepPurple.shade300,
                "The password reset link has been sent to your email. Please Check Your Email."));
        Navigator.pop(context);

        print("sent ");
      } catch (e) {
        showSnackbar(context, Colors.red, e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          title: const Text(
            "Reset Password",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/appbar.png",
                      ),
                      radius: 70,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        userInputWidget(),
                        loginButton(context),
                        Sign_up(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget userInputWidget() {
    return TextFormField(
      onSaved: (value) {
        _email = value!;
      },
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.emailAddress,
      key: const ValueKey('email'),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
    );
  }

  Widget loginButton(BuildContext _context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(100),
            ),
            child: MaterialButton(
              onPressed: _submitData,
              child: const Center(
                child: Text("Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
          );
  }

  Widget Sign_up(BuildContext _context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: const Text(
            " Login with password.",
            style: TextStyle(
                fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ],
    );
  }
}
