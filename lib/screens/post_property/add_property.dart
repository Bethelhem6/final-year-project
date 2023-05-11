import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<File> _housePictures = [];

  Future<void> _addHouseToFirebase() async {
    String address = _addressController.text;
    int bedrooms = int.parse(_bedroomsController.text);
    double price = double.parse(_priceController.text);

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference housesRef = firestore.collection('houses');

      DocumentReference newHouseRef = await housesRef.add({
        'address': address,
        'bedrooms': bedrooms,
        'price': price,
      });

      for (File picture in _housePictures) {
        String pictureName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('houses/${newHouseRef.id}/$pictureName');
        await storageRef.putFile(picture);
        String pictureUrl = await storageRef.getDownloadURL();
        await newHouseRef.collection('pictures').add({'url': pictureUrl});
      }

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('House added successfully to Firebase Firestore!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearTextFields();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          print("e");
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add house to Firebase Firestore.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _pickHousePicture() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _housePictures.add(File(pickedFile.path));
      });
    }
  }

  void _clearTextFields() {
    _addressController.clear();
    _bedroomsController.clear();
    _priceController.clear();
    setState(() {
      _housePictures.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add House'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bedroomsController,
              decoration: InputDecoration(labelText: 'Bedrooms'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    child: Text('Add Picture'),
                    onPressed: _pickHousePicture,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                children: _housePictures.map((File picture) {
                  return Image.file(picture);
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            MaterialButton(
              child: Text('Add House'),
              onPressed: _addHouseToFirebase,
            ),
          ],
        ),
      ),
    );
  }
}

// 
