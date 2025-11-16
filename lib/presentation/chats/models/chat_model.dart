// ignore_for_file: collection_methods_unrelated_type

import 'package:test_ejar/presentation/chats/models/message_model.dart';
import 'package:test_ejar/presentation/chats/models/user_model.dart';

class ChatModel {
  String? id;
  List<MessageModel> messages;
  List<String>? users;
  String?userId;
  MessageModel? lastMessage;
 final UserModel otherUser;
  
  ChatModel({
    this.id,
    required this.userId,
    required this.messages,
    this.users,
    this.lastMessage,
   required this.otherUser,
  });factory ChatModel.fromJson(
  Map<String, dynamic> json,
  MessageModel lastMessage,
  UserModel otherUser,
  String userId
) {
  List<MessageModel> parsedMessages = [];

  if (json['messages'] is List) {
    parsedMessages = (json['messages'] as List)
        .map((message) => MessageModel.fromMap(message as Map<String, dynamic>))
        .toList();
  } else if (json['messages'] is Map) {
    parsedMessages = (json['messages'] as Map<String, dynamic>)
        .values
        .map((message) => MessageModel.fromMap(message as Map<String, dynamic>))
        .toList();
  }

  return ChatModel(
    id: json['id'],
    messages: parsedMessages,
    users: (json['users'] as List<dynamic>).map((e) => e.toString()).toList(),
    lastMessage: lastMessage,
    otherUser: otherUser,
    userId: userId
  );
}

}
//qOvjS5fooZYt8cQ8PLuOtSqVxZt2-XiRpgPzKJwXz2gMeVH85LUjTFMv1
//09a459edbc@emailwww.pro
//XiRpgPzKJwXz2gMeVH85LUjTFMv1