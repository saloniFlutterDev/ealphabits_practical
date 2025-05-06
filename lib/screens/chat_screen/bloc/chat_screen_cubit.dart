import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ealphabits_practical/screens/chat_screen/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreenCubit extends Cubit<List<MessageModel>> {
  ChatScreenCubit() : super([]);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isMessageValid(String message){
    return message.replaceAll(" ", "").isNotEmpty;
  }

void listenToMessages(String receiverId) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = getChatId(currentUserId, receiverId);

    firestore.collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('sendAt', descending: false)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        return MessageModel.fromJson({
          ...doc.data(),
          'messageId': doc.id, // include doc ID
        });
      }).toList();

      emit(messages); // update your Cubit state
    });
  }

  Future<void> sendMessage(String receiverId, String messageText) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = getChatId(currentUserId, receiverId); // assumes your custom logic
    final messageDoc = firestore.collection('messages').doc();

    final message = MessageModel(
      chatId: chatId,
      receiverId: receiverId,
      senderId: currentUserId,
      message: messageText,
      messageId: messageDoc.id,
      sendAt: DateTime.now().toString(),
    );

    try {
      await messageDoc.set({
        ...message.toJson(),
        'sendAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }
  String extractTime(String datetimeString) {
      DateTime dateTime = DateTime.parse(datetimeString);
      return DateFormat('HH:mm').format(dateTime);
    }

  String getChatId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }
}