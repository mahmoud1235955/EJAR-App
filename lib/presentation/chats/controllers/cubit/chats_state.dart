part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class ChatsLoaded extends ChatsState {
  final List<ChatModel> chats;
  ChatsLoaded(this.chats);
}

final class ChatsError extends ChatsState {
  final String message;
  ChatsError({required this.message});
}
