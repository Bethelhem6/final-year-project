// ignore_for_file: unused_field, use_build_context_synchronously, prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_application_1/global_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadPackages extends StatefulWidget {
  String? title;
  String? id;
  String? image;
  var price;
  String? description;
  UploadPackages(
      {Key? key, this.description, this.price, this.title, this.image, this.id})
      : super(key: key);
  @override
  State<UploadPackages> createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadPackages> {
  var _packageTitle = "";
  var _packageDescription = "";
  var _packagePrice = "";

  final _formKey = GlobalKey<FormState>();
  String _url = '';
  var uuid = const Uuid();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  File? _image;
  _trySubmit() async {
    print(_packageDescription);
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
    try {
      if (_image == null) {
        print('Please provide an image');
      } else {
        setState(() {
          _isLoading = true;
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child('product')
            .child('$_packageTitle.jpg');
        await ref.putFile(_image!);
        _url = await ref.getDownloadURL();

        final packageId = uuid.v4();
        // final User? user = _auth.currentUser;
        // final _uid = user!.uid;

        await FirebaseFirestore.instance
            .collection('packages')
            .doc(packageId)
            .set({
          'title': _packageTitle,
          'description': _packageDescription,
          'price': _packagePrice,
          'image': _url,
          'id': packageId,
          'createdAt': Timestamp.now()
        });
        Navigator.pop(context);
        // _globalMethods.showDialogues(context, "Successfully Added.");
      }
    } catch (e) {
      // _globalMethods.showDialogues(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _getGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
      });
    } catch (e) {
      // _globalMethods.showDialogues(context, "Image is needed.");
    }
  }

  Future _getCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      setState(() {
        _image = File(image!.path);
      });
    } catch (e) {
      // _globalMethods.showDialogues(context, "Image is needed.");
    }
  }

  void _removeImage() {
    try {
      setState(() {
        _image = null;
      });
    } catch (e) {
      // _globalMethods.showDialogues(context, "No image to be deleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Add New Packages"),
        elevation: 0,
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            print(_packageTitle);
            _trySubmit();
          },
          child: Container(
            alignment: Alignment.center,
            height: 45,
            color: Colors.purple,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : const Text(
                    'Add Package',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _image == null
                            ? Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  // image: const DecorationImage(
                                  //     image: AssetImage("assets/mocha.jpg"),
                                  //     fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                                // ignore: prefer_const_constructors

                                //   child: Image(
                                //       image: AssetImage("assets/empty_gal.jpg")),
                              )
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                      Column(
                        children: [
                          TextButton.icon(
                            onPressed: _getCameraImage,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Camera'),
                          ),
                          TextButton.icon(
                            onPressed: _getGalleryImage,
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                          TextButton.icon(
                            onPressed: _removeImage,
                            icon: const Icon(Icons.remove_circle),
                            label: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Column(
                    children: [
                      TextFormField(
                        initialValue: widget.title,
                        key: const ValueKey('title'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Title',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onSaved: (val) {
                          _packageTitle = val.toString();
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: widget.price,
                        key: const ValueKey('price'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Price is missing';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Price Birr',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onSaved: (val) {
                          _packagePrice = val.toString();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                      initialValue: widget.description,
                      key: const ValueKey('Description'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'package description is required';
                        }
                        return null;
                      },
                      //controller: this._controller,
                      maxLines: 10,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        //  counterText: charLength.toString(),
                        labelText: 'Description',
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hintText: 'Package description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onSaved: (value) {
                        _packageDescription = value.toString();
                      },
                      onChanged: (text) {
                        // setState(() => charLength -= text.length);
                      }),
                  //    SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
