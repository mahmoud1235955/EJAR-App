import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? sender;
  String? message;
  Timestamp? timestamp;

  MessageModel({this.sender, this.message, this.timestamp});
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp),
    );
  }
}
