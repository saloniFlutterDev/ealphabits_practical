import 'package:ealphabits_practical/screens/chat_screen/bloc/chat_screen_cubit.dart';
import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key, required this.messageModel});
  final MessageModel messageModel;
  final ChatScreenCubit chatScreenCubit = ChatScreenCubit();


  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Align(
        alignment: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child:Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8,
            children: [
              Flexible(child: Text(messageModel.message ?? '', style: BaseTextStyle.subtitleTextStyle)),
              Text(chatScreenCubit.extractTime(messageModel.sendAt), style: BaseTextStyle.dateTimeTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
