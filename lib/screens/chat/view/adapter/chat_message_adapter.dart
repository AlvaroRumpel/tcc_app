import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/models/message_model.dart';
import 'package:tcc_app/widgets/texts/message_text.dart';

class ChatMessageAdapter extends StatelessWidget {
  MessageModel message;
  ChatMessageAdapter({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message.whoSent == FirebaseAuth.instance.currentUser?.uid
        ? Align(
            alignment: Alignment.centerRight,
            child: MessageText(
              text: message.message,
              isWhoSent: true,
              time: message.sendDate,
            ),
          )
        : Container(
            alignment: Alignment.centerLeft,
            child: MessageText(
              text: message.message,
              isWhoSent: false,
              time: message.sendDate,
            ),
          );
  }
}
