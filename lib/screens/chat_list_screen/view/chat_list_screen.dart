import 'package:cached_network_image/cached_network_image.dart';
import 'package:ealphabits_practical/screens/chat_list_screen/bloc/chat_list_screen_cubit.dart';
import 'package:ealphabits_practical/screens/chat_list_screen/model/chat_user_model.dart';
import 'package:ealphabits_practical/screens/chat_screen/view/chat_screen.dart';
import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatListScreenCubit chatListScreenCubit = ChatListScreenCubit();

  @override
  void initState() {
    // TODO: implement initState
    chatListScreenCubit.addUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatListScreenCubit,
      child: Scaffold(
        appBar: AppBar(title: Text(BaseStrings.chatListScreenTitle, style: BaseTextStyle.chatListScreenTitle)),
        body: BlocBuilder<ChatListScreenCubit, List<ChatUserModel>>(
          builder: (context, userListState) {
            if (userListState.isEmpty) {
              return Center(child: Text(BaseStrings.noUsersAvailable));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemCount: userListState.length,
              itemBuilder: (context, index) {
                return InkWell(
                  focusColor: BaseColorConstants.textSecondary,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(chatUserModel: userListState[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: userListState[index].profileImgUrl,
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userListState[index].name, style: BaseTextStyle.titleTextStyle),
                              const SizedBox(height: 4),
                              Text(userListState[index].lastMessage, style: BaseTextStyle.subtitleTextStyle, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: BaseColorConstants.divider, height: 1);
              },
            );
          },
        ),
      ),
    );
  }
}
