import 'package:cached_network_image/cached_network_image.dart';
import 'package:ealphabits_practical/core/services/socket_services.dart';
import 'package:ealphabits_practical/screens/chat_list_screen/model/chat_user_model.dart';
import 'package:ealphabits_practical/screens/chat_screen/bloc/chat_screen_cubit.dart';
import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:ealphabits_practical/screens/chat_screen/view/widgets/message_view.dart';
import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatUserModel});

  final ChatUserModel chatUserModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ChatScreenCubit chatScreenCubit = ChatScreenCubit();
  final uuid = Uuid();
final SocketService socketService = SocketService();
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage() {
    if (chatScreenCubit.isMessageValid(messageController.text)) {
      final message = MessageModel(
        chatId: widget.chatUserModel.chatId,
        receiverId: widget.chatUserModel.userId,
        senderId: BaseStrings.staticUserId,
        message: messageController.text,
        messageId: uuid.v1(),
        sendAt: DateTime.now().toString(),
      );
      chatScreenCubit.addMessage(message);
      messageController.clear();
      Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
    }
  }
@override
  void initState() {
    // TODO: implement initState
  // socketService.connectSocket();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatScreenCubit,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: Column(
            children: [
              buildMessageList(),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.chatUserModel.profileImgUrl,
              height: 35,
              width: 35,
              fit: BoxFit.cover,
              placeholder: (_, __) => const CircularProgressIndicator(),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 10),
          Text(widget.chatUserModel.name, style: BaseTextStyle.titleTextStyle),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return Expanded(
      child: BlocBuilder<ChatScreenCubit, List<MessageModel>>(
        builder: (context, messageState) {
          return ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            itemCount: messageState.length,
            itemBuilder: (context, index) {
              return MessageView(messageModel: messageState[index]);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }

  Widget buildMessageInput() {
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
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder inputBorder({double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: BaseColorConstants.background, width: width),
    );
  }
}
