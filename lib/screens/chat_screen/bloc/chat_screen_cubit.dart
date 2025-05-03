import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreenCubit extends Cubit<List<MessageModel>> {
  ChatScreenCubit() : super([]);

  void addMessage(MessageModel model) {
    emit([...state, model]); // Adds the new message to the existing list
  }

  String extractTime(String datetimeString) {
    DateTime dateTime = DateTime.parse(datetimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  bool isMessageValid(String message){
    return message.replaceAll(" ", "").isNotEmpty;
  }

}