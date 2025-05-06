import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:ealphabits_practical/screens/chat_screen/view/widgets/message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/base_color_constants.dart';
import '../../../utils/base_strings.dart';
import '../bloc/chat_screen_cubit.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverName;

  ChatScreen({required this.receiverId, required this.receiverName});

  final TextEditingController messageController = TextEditingController();
  final ChatScreenCubit chatScreenCubit = ChatScreenCubit();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatScreenCubit()..listenToMessages(receiverId),
      child: BlocBuilder<ChatScreenCubit, List<MessageModel>>(
        builder: (context, messages) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(title: Text(receiverName)),
              body: Column(children: [buildMessageList(messages), buildMessageInput(context)]),
            ),
          );
        },
      ),
    );
  }

  Widget buildMessageList(List<MessageModel> messages) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (_, index) {
          final msg = messages[index];
          return MessageView(messageModel: msg);
        },
      ),
    );
  }

  Widget buildMessageInput(BuildContext context) {
    return Container(
      color: BaseColorConstants.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: BaseColorConstants.background,
                hintText: BaseStrings.message,
                enabledBorder: inputBorder(),
                focusedBorder: inputBorder(width: 2),
                border: inputBorder(),
              ),
              cursorColor: Colors.white,
              validator: (value) => (value?.isEmpty ?? true) ? 'Please enter some text' : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: BaseColorConstants.background,
            onPressed: () {
              final text = messageController.text.trim();
              if (text.isNotEmpty) {
                if (chatScreenCubit.isMessageValid(messageController.text)) {
                  context.read<ChatScreenCubit>().sendMessage(receiverId, text);
                  messageController.clear();
                  Future.delayed(const Duration(milliseconds: 300), scrollToBottom);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  OutlineInputBorder inputBorder({double width = 1}) {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: BaseColorConstants.background, width: width));
  }
}
