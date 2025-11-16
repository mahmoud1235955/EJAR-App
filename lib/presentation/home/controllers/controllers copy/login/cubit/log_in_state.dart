part of 'log_in_cubit.dart';

@immutable
abstract class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInsuccess extends LogInState {
  
}

final class LogInError extends LogInState {
  final String errorMessage;

  LogInError({required this.errorMessage});
}

final class LogInvisible extends LogInState {
  final bool isVisible;

  LogInvisible({required this.isVisible});
}
