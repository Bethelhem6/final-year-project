import 'package:flutter/material.dart';

import '../../helper/helper.dart';
import '../../models/model.dart';
import '../../utils/Constants.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              toolbarHeight: 70,
              title: Text(widget.user.name)),
          floatingActionButton: //user about
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined On: ',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                  MyDateUtil.getLastMessageTime(
                      context: context,
                      time: widget.user.createdAt,
                      showYear: true),
                  style: const TextStyle(color: Colors.black54, fontSize: 15)),
            ],
          ),

          //body
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Constants.mq["width"]! * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(
                      width: Constants.mq["width"]!,
                      height: Constants.mq["height"]! * .03),

                  //user profile picture
                  ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Constants.mq["height"]! * .13),
                      child: Container(
                          width: Constants.mq["height"]! * .20,
                          height: Constants.mq["height"]! * .20,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.user.image.toString()))))),

                  // for adding some space
                  SizedBox(height: Constants.mq["height"]! * .03),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(120, 2, 0, 3),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        Icon(Icons.star, color: Colors.red),
                        Icon(Icons.star, color: Colors.red),
                        Icon(Icons.star),
                        Icon(Icons.star),
                      ],
                    ),
                  ),

                  // user email label
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.deepPurple.shade700,
                      ),
                      title: const Text("Name"),
                      subtitle: Text(widget.user.name),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Colors.green.shade700,
                      ),
                      title: const Text("Phone NUmber"),
                      subtitle: Text(widget.user.email),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.yellow.shade700,
                      ),
                      title: const Text("Email"),
                      subtitle: Text(widget.user.email),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.description,
                        color: Colors.blue,
                      ),
                      title: const Text("About"),
                      subtitle: Text(widget.user.about),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.history,
                        color: Colors.redAccent.shade100,
                      ),
                      title: const Text("Posts"),
                      subtitle: Text(widget.user.about),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
