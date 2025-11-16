part of 'forgot_cubit.dart';

@immutable
abstract class ForgotState {}

final class ForgotInitial extends ForgotState {}

final class ForgotLoading extends ForgotState {}

final class ForgotSuccess extends ForgotState {}

final class ForgotError extends ForgotState {
  final String message;

  ForgotError({required this.message});
}
