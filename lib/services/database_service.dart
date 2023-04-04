import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  late final String uid;
  DatabaseService({required this.uid});
  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");

  Future updateUserData(String firstname, String email) async{
    return await userCollection.doc(uid).set({
      "firstname": firstname,
      "email": email,
      "groups": [],
      "profilePic": '',
      'uid': uid,
      });
  }
}