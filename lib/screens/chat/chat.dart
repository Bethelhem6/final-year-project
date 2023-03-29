import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../models/chat_user_model.dart';
import '../../widgets/widgets.dart';
import '../user_profile/user_profile.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Afrah muhammed",
        messageText: "Hey where are you?",
        imageURL: "assets/profile1.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Bethelhem misgna",
        messageText: "Awesome Setup",
        imageURL: "assets/profile1.jpg",
        time: "Now"),
    ChatUsers(
        name: "yabsira Adamu ",
        messageText: "That's Great",
        imageURL: "assets/profile1.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "yordanos daniel",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "assets/profile1.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "foziya muhammed",
        messageText: "Thankyou, It's awesome",
        imageURL: "assets/profile1.jpg",
        time: "23 Mar"),
    ChatUsers(
        name: "heaven nati",
        messageText: "will update you in evening",
        imageURL: "assets/profile1.jpg",
        time: "17 Mar"),
    ChatUsers(
        name: "bethelhem girma",
        messageText: "Can you please share the file?",
        imageURL: "assets/profile1.jpg",
        time: "24 Feb"),
    ChatUsers(
        name: "Atsede woynmolla",
        messageText: "How are you?",
        imageURL: "assets/profile1.jpg",
        time: "18 Feb"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact users'),
        backgroundColor: appbarColor,
        centerTitle: true,
        toolbarHeight: 80,
        toolbarOpacity: 0.8,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // const Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const user_profile()),
                                );
                              },
                              child: const Text(
                                "Add New",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
