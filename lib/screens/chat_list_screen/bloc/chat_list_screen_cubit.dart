import 'package:ealphabits_practical/screens/chat_list_screen/model/chat_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatListScreenCubit extends Cubit<List<ChatUserModel>> {
  ChatListScreenCubit() : super([]);

  addUserData(){
    final List<ChatUserModel> chatUserModel = [
      ChatUserModel(
        chatId: '1',
        name: 'Support Bot',
        lastMessage: 'Hey, how are you?',
        userId: '1111',
        profileImgUrl: 'https://i.pravatar.cc/150?img=1',
        sendAt: DateTime.now(),
      ),
      ChatUserModel(
        chatId: '2',
        name: 'Sales Bot',
        lastMessage: 'Let\'s catch up tomorrow.',
        userId:'1112',
        profileImgUrl: 'https://i.pravatar.cc/150?img=2',
        sendAt: DateTime.now(),
      ),
      ChatUserModel(
        chatId: '3',
        name: 'FAQ Bot',
        lastMessage: 'Got the files you sent.',
        userId:'1113',
        profileImgUrl: 'https://i.pravatar.cc/150?img=3',
        sendAt: DateTime.now(),
      ),
    ];
    emit(chatUserModel);
  }

}


