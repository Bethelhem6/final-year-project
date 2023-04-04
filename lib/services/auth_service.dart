import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String firstname, String lastname, String email, int phonenumber, String password) async{
    try{
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password)).user;
      if(user != null){
        await DatabaseService(uid: user.uid).updateUserData(firstname,email);
        return true;
      }
    } on FirebaseAuthException catch (e){
      print(e);
      return e; 
    }
  }

}

