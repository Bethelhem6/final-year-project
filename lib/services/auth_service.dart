import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';


import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File? _image;

  Future loginUser(
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUser(String fullname, String email, String password,
      String phonenumber, String image) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DatabaseService(uid: user.uid)
          .updateUserData(email, fullname,phonenumber, image,);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
