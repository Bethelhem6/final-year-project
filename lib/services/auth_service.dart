import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
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

  Future registerUser(String name, String email, String password,
      String phonenumber, String _imageP) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DatabaseService(uid: user.uid)
          .updateUserData(email, name, phonenumber, _imageP,);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
