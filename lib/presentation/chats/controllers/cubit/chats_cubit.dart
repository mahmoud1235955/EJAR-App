import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/chats/models/chat_model.dart';
import 'package:test_ejar/presentation/chats/models/message_model.dart';
import 'package:test_ejar/presentation/chats/models/user_model.dart';
part 'chats_state.dart';
class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _chatsSubscription;
  Future<void> getChats() async {
    try {
      emit(ChatsLoading());
      final currentUserId = firebaseAuth.currentUser!.uid;

      // لو فيه اشتراك قديم الغيه
      await _chatsSubscription?.cancel();

      _chatsSubscription = firestore
          .collection("chats")
          .where("users", arrayContains: currentUserId)
          .snapshots()
          .listen(
            (snapshot) async {
              List<ChatModel> chats = [];
              for (var chat in snapshot.docs) {
                final chatData = chat.data();
                // تحقق من وجود users
                if (chatData["users"] == null || chatData["users"].length < 2) {
                  continue; // تجاهل الشات لو ناقص بيانات
                }
                final List<String> chatUsers = List<String>.from(
                  chatData["users"],
                );

                // جلب الـ other user
                final otherUserId = chatUsers.firstWhere(
                  (id) => id != currentUserId,
                  orElse: () => "",
                );
                if (otherUserId.isEmpty) continue;

                // بيانات المستخدم الآخر
                final otherUserDoc = await firestore
                    .collection("users")
                    .doc(otherUserId)
                    .get();

                if (!otherUserDoc.exists) continue;

                final otherUser = UserModel.fromJson(otherUserDoc.data()!);

                // آخر رسالة
                MessageModel? lastMessage;
                if (chatData["lastMessage"] != null) {
                  lastMessage = MessageModel.fromMap(
                    Map<String, dynamic>.from(chatData["lastMessage"]),
                  );
                }

                final chatModel = ChatModel.fromJson(
                  chatData,
                  lastMessage ?? MessageModel(),
                  otherUser,
                  otherUserId,
                );
                chats.add(chatModel);
              }

              // ترتيب حسب آخر رسالة (الأحدث أولاً)
              chats.sort((a, b) {
                // لو a مفيهوش lastMessage → رجعه بعد b
                if (a.lastMessage == null) return 1;
                // لو b مفيهوش lastMessage → رجعه بعد a
                if (b.lastMessage == null) return -1;

                // لو timestamp نفسه null
                if (a.lastMessage!.timestamp == null) return 1;
                if (b.lastMessage!.timestamp == null) return -1;

                // مقارنة timestamps
                return b.lastMessage!.timestamp!.compareTo(
                  a.lastMessage!.timestamp!,
                );
              });

              emit(ChatsLoaded(chats));
            },
            onError: (error) {
              emit(ChatsError(message: error.toString()));
            },
          );
    } catch (error) {
      emit(ChatsError(message: error.toString()));
    }
  }

  // ✅ فتح شات (أو إنشاء جديد)
  Future<String> openChat(String otherUserId) async {
    try {
      final currentUserId = firebaseAuth.currentUser!.uid;

      final chat1 = await firestore
          .collection("chats")
          .doc("${currentUserId}_$otherUserId")
          .get();
      final chat2 = await firestore
          .collection("chats")
          .doc("${otherUserId}_$currentUserId")
          .get();

      if (chat1.exists) {
        return chat1.id;
      } else if (chat2.exists) {
        return chat2.id;
      } else {
        final chatId = "${currentUserId}_$otherUserId";
        await firestore.collection("chats").doc(chatId).set({
          "id": chatId,
          "users": [currentUserId, otherUserId],
        });
        return chatId;
      }
    } catch (error) {
      throw Exception("Failed to open chat: $error");
    }
  }
  // ✅ إرسال رسالة
  Future<void> sendMessage(String chatId, String message) async {
    try {
      final currentUserId = firebaseAuth.currentUser!.uid;

      final newMessage = {
        "sender": currentUserId,
        "message": message,
        "timestamp": Timestamp.now(),
      };
      // أضف الرسالة في SubCollection
      await firestore
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .add(newMessage);

      // حدث آخر رسالة في Document الشات
      await firestore.collection("chats").doc(chatId).update({
        "lastMessage": newMessage,
      });
    } catch (error) {
      throw Exception("Failed to send message: $error");
    }
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
