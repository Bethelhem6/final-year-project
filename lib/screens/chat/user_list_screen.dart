import 'dart:developer';

import 'package:final_project/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/apis.dart';
import '../../models/model.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

//home screen -- where all available contacts are shown
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // for storing all users
  List<ChatUser> _list = [];

  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return GestureDetector(
      //for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if search is on & back button is pressed then close search
        //or else simple close current screen on back button click
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            //app bar
            appBar: AppBar(
              // backgroundColor: appbarColor,
              centerTitle: true,
              toolbarHeight: 80,
              toolbarOpacity: 0.8,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              // leading: const Icon(CupertinoIcons.home),
              title: _isSearching
                  ? TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name, Email, ...'),
                      autofocus: true,
                      style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                      //when search text changes then updated search list
                      onChanged: (val) {
                        //search logic
                        _searchList.clear();

                        for (var i in _list) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(val.toLowerCase())) {
                            _searchList.add(i);
                            setState(() {
                              _searchList;
                            });
                          }
                        }
                      },
                    )
                  : const Text(
                      'Message',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
              actions: [
                //search user button
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    icon: Icon(_isSearching
                        ? CupertinoIcons.clear_circled_solid
                        : Icons.search)),

                //more features button
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(user: APIs.me)));
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),

            //floating button to add new user
            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: FloatingActionButton(
            //       onPressed: () {
            //         _addChatUserDialog();
            //       },
            //       child: const Icon(Icons.add_comment_rounded)),
            // ),

            //body
            body: StreamBuilder(
              stream: APIs.getAllUsers(APIs.user.uid),

              //get only those user, who's ids are provided
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  // return const Center(
                  //     child: CircularProgressIndicator());

                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
                        [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                          itemCount:
                              _isSearching ? _searchList.length : _list.length,
                          padding: EdgeInsets.only(top: mq.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ChatUserCard(
                                user: _isSearching
                                    ? _searchList[index]
                                    : _list[index]);
                          });
                    } else {
                      return const Center(
                        child: Text('No Connections Found!',
                            style: TextStyle(fontSize: 20)),
                      );
                    }
                }
              },
            )),
      ),
    );
  }

  // for adding new chat user
}
