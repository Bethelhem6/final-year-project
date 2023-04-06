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
          appBar: AppBar(title: Text(widget.user.name)),
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
            padding: EdgeInsets.symmetric(horizontal: Constants.mq["width"]! * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(width: Constants.mq["width"]!, height: Constants.mq["height"]! * .03),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Constants.mq["height"]! * .1),
                    // child: CachedNetworkImage(
                    //   width: Constants.mq["height"]! * .2,
                    //   height: Constants.mq["height"]! * .2,
                    //   fit: BoxFit.cover,
                    //   imageUrl: widget.user.image,
                    //   errorWidget: (context, url, error) => const CircleAvatar(
                    //       child: Icon(CupertinoIcons.person)),
                    // ),
                  ),

                  // for adding some space
                  SizedBox(height: Constants.mq["height"]! * .03),

                  // user email label
                  Text(widget.user.email,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16)),

                  // for adding some space
                  SizedBox(height: Constants.mq["height"]! * .02),

                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.about,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
