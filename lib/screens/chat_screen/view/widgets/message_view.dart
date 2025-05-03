import 'package:ealphabits_practical/screens/chat_screen/bloc/chat_screen_cubit.dart';
import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key, required this.messageModel});
  final MessageModel messageModel;
  final ChatScreenCubit chatScreenCubit = ChatScreenCubit();


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: messageModel.senderId == BaseStrings.staticUserId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 10, maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8,
            children: [
              Flexible(child: Text(messageModel.message, style: BaseTextStyle.subtitleTextStyle)),
              Text(chatScreenCubit.extractTime(messageModel.sendAt), style: BaseTextStyle.dateTimeTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
