import 'package:flutter/material.dart';

import '../../models/model.dart';
import '../screens/screens.dart';
import '../utils/Constants.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: Constants.mq["width"]!* .6,
          height: Constants.mq["height"]!* .35,
          child: Stack(
            children: [
              //user profile picture
              // Positioned(
              //   top: Constants.mq["width"]! * .075,
              //   left: mq.width * .1,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(mq.height * .25),
              //     child: CachedNetworkImage(
              //       width: mq.width * .5,
              //       fit: BoxFit.cover,
              //       imageUrl: user.image,
              //       errorWidget: (context, url, error) =>
              //           const CircleAvatar(child: Icon(CupertinoIcons.person)),
              //     ),
              //   ),
              // ),

              //user name
              Positioned(
                left: Constants.mq["width"]! * .04,
                top: Constants.mq["height"]! * .02,
                width: Constants.mq["width"]! * .55,
                child: Text(user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),

              //info button
              Positioned(
                  right: 8,
                  top: 6,
                  child: MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProfileScreen(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ))
            ],
          )),
    );
  }
}
