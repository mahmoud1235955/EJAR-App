import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استقبل Cubit اللي جاي من AccountScreen
    final chatsCubit = ModalRoute.of(context)!.settings.arguments as ChatsCubit;

    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        bloc: chatsCubit, // <-- استخدمه هنا
        builder: (context, state) {
          if (state is ChatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatsLoaded) {
            final chats = state.chats;
            if (chats.isEmpty) {
              return const Center(child: Text("No chats yet"));
            }
            return ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final chat = chats[index];
                if (chat.otherUser != null && chat.lastMessage != null) {
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(chat.otherUser.name!),
                    subtitle: Text(chat.lastMessage!.message!),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.viewChats,
                        arguments: chat.userId,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          } else {
            return const Center(child: Text("Error loading chats"));
          
          }
        },
      ),
    );
  }
}
