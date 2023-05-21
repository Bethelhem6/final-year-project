import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

// ignore: camel_case_types
class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = "";
  String _name = "";
  String _email = "";
  String _phonenumber = "";
  var _imageP;
  File? _image;
  XFile? imgXFile;

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    setState(() {
      _name = userDocs.get('name');
      _email = userDocs.get('email');
      _imageP = userDocs.get('image');
      _phonenumber = userDocs.get('phonenumber');
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
    final ref =
        FirebaseStorage.instance.ref().child('userimages').child('$_name.jpg');

    await ref.putFile(_image!);
    _imageP = await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("users").doc(_uid).update({
      "image": _imageP,
    });
    setState(() {});
  }

  logoutMessage() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to Logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  User? user = _auth.currentUser;
                  _uid = user!.uid;
                  await _auth.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 70,
        title: const Text("My Profile"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Colors.black12, Colors.white],
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //     stops: [0.5, 0.9],
            //   ),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundColor: Colors.red.shade300,
                    //   minRadius: 35.0,
                    //   child: Icon(
                    //     Icons.call,
                    //     size: 30.0,
                    //   ),
                    // ),

                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 80.0,
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage:
                            _imageP == "" ? null : NetworkImage(_imageP!),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(135, 0, 0, 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.camera_front,
                        color: Colors.deepPurple,
                      ),
                      GestureDetector(
                          onTap: _getImage,
                          child: const Text(
                            "Change Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.deepPurple),
                //   onPressed: () {},
                //   icon: const Icon(Icons.edit),
                //   label: const Text('Edit profile'),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              "User Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    title: const Text(
                      "User Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                // Divider(),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  //  color: Colors.grey[100],
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.deepOrange,
                    ),
                    title: const Text(
                      'Phone number',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _phonenumber,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // Divider(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                  //  color: Colors.grey[100],
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    title: const Text(
                      'Email',
                      style: TextStyle(
                        // color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _email,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                  //  color: Colors.grey[100],
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.all(5),

                  child: const ListTile(
                    leading: Icon(
                      Icons.location_city_rounded,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Adress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Addis Ababa',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "User Setting",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => const SendNot())));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),

                    //  color: Colors.grey[100],
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    margin: const EdgeInsets.all(5),

                    child: const ListTile(
                      leading: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.purple,
                      ),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                  //  color: Colors.grey[100],
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  margin: const EdgeInsets.all(5),

                  child: ListTile(
                    onTap: logoutMessage,
                    // await FirebaseAuth.instance.signOut();

                    // Navigator.pop(context);

                    // Navigator.pop(context);

                    // Navigator.pop(context);

                    //   Navigator.pushReplacement(context,
                    //       MaterialPageRoute(builder: (context) => LoginPage()));
                    // },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
