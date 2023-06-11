import 'dart:developer';

import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../api/apis.dart';
import '../helper/helper.dart';
import '../models/model.dart';

// for showing single message details
class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == widget.message.fromId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _greenMessage() : _blueMessage());
  }

  // sender or another user message
  Widget _blueMessage() {
    //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding:
                EdgeInsets.all(widget.message.type == Type.image ? 30 : 40),
            margin: const EdgeInsets.symmetric(
                horizontal: 400 * .04, vertical: 800 * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                // border: Border.all(color: appbarColor),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.message.msg))),
                      // placeholder: (context, url) => const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: CircularProgressIndicator(strokeWidth: 2),
                      // ),
                      // errorWidget: (context, url, error) =>
                      //     const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        //message time
        Padding(
          padding: const EdgeInsets.only(right: 400 * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            const SizedBox(width: 400 * .04),

            //double tick blue icon for message read
            if (widget.message.read.isNotEmpty)
              Icon(Icons.done_all_rounded, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
                widget.message.type == Type.image ? 400 * .03 : 400 * .04),
            margin: const EdgeInsets.symmetric(
                horizontal: 400 * .04, vertical: 800 * .01),
            decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                border: Border.all(color: Colors.deepPurple.shade300),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.message.msg))),
                      //   placeholder: (context, url) => const Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: CircularProgressIndicator(strokeWidth: 2),
                      //   ),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // bottom sheet for modifying message details
  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              //black divider
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(
                    vertical: 800 * .015, horizontal: 400 * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              widget.message.type == Type.text
                  ?
                  //copy option
                  _OptionItem(
                      icon: Icon(Icons.copy_all_rounded, size: 26),
                      name: 'Copy Text',
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.msg))
                            .then((value) {
                          //for hiding bottom sheet
                          Navigator.pop(context);

                          Dialogs.showSnackbar(context, 'Text Copied!');
                        });
                      })
                  :
                  //save option
                  _OptionItem(
                      icon: Icon(Icons.download_rounded, size: 26),
                      name: 'Save Image',
                      onTap: () async {
                        try {
                          log('Image Url: ${widget.message.msg}');
                          await GallerySaver.saveImage(widget.message.msg,
                                  albumName: 'We Chat')
                              .then((success) {
                            //for hiding bottom sheet
                            Navigator.pop(context);
                            if (success != null && success) {
                              Dialogs.showSnackbar(
                                  context, 'Image Successfully Saved!');
                            }
                          });
                        } catch (e) {
                          log('ErrorWhileSavingImg: $e');
                        }
                      }),

              //separator or divider
              if (isMe)
                const Divider(
                  color: Colors.black54,
                  endIndent: 400 * .04,
                  indent: 400 * .04,
                ),

              //edit option
              if (widget.message.type == Type.text && isMe)
                _OptionItem(
                    icon: Icon(Icons.edit, size: 26),
                    name: 'Edit Message',
                    onTap: () {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      _showMessageUpdateDialog();
                    }),

              //delete option
              if (isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      await APIs.deleteMessage(widget.message).then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      });
                    }),

              //separator or divider
              const Divider(
                color: Colors.black54,
                endIndent: 400 * .04,
                indent: 400 * .04,
              ),

              //sent time
              _OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                  ),
                  name:
                      'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent)}',
                  onTap: () {}),

              //read time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                  name: widget.message.read.isEmpty
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.read)}',
                  onTap: () {}),
            ],
          );
        });
  }

  //dialog for updating message content
  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: [
                  Icon(
                    Icons.message,
                    size: 28,
                  ),
                  const Text(' Update Message')
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMsg,
                maxLines: null,
                onChanged: (value) => updatedMsg = value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    )),

                //update button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                      APIs.updateMessage(widget.message, updatedMsg);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ));
  }
}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 400 * .05, top: 800 * .015, bottom: 800 * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15, color: Colors.white, letterSpacing: 0.5)))
          ]),
        ));
  }
}
