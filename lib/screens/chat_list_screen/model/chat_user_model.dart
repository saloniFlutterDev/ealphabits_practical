class ChatUserModel {
  final String chatId;
  final String name;
  final String lastMessage;
  final String userId;
  final String profileImgUrl;
  final DateTime sendAt;

  ChatUserModel({required this.chatId, required this.name, required this.lastMessage,required this.userId, required this.profileImgUrl, required this.sendAt});

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      chatId: json['chatId'],
      name: json['name'],
      lastMessage: json['lastMessage'],
      userId: json['userId'],
      profileImgUrl: json['profileImgUrl'],
      sendAt: json['sendAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'chatId': chatId, 'name': name, 'lastMessage': lastMessage, 'userId': userId, 'profileImgUrl': profileImgUrl, 'sendAt': sendAt};
  }
}
