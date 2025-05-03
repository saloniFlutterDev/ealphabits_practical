import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:flutter/material.dart';

class ChatNoInternetScreen extends StatelessWidget {
  const ChatNoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(BaseStrings.noInternetConnection, style:BaseTextStyle.titleTextStyle),
          SizedBox(height: 8),
          Text(BaseStrings.noInternetConnectionSubtitle, textAlign: TextAlign.center, style: BaseTextStyle.chatListScreenTitle),
        ],
      ),
    );
  }
}
