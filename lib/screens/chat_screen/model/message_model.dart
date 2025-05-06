import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String chatId;
  final String receiverId;
  final String senderId;
  final String message;
  final String messageId;
  final String sendAt;

  MessageModel({
    required this.chatId,
    required this.receiverId,
    required this.senderId,
    required this.message,
    required this.messageId,
    required this.sendAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chatId'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      message: json['message'],
      messageId: json['messageId'],
      sendAt: json['sendAt'] != null
    ? (json['sendAt'] as Timestamp).toDate().toString()
        : DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'chatId': chatId, 'receiverId': receiverId, 'senderId': senderId, 'message': message, 'messageId': messageId, 'sendAt': sendAt};
  }
}
