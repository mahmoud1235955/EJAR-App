part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class NormalSplash extends SignUpState {}

final class SignUpsuccess extends SignUpState {}

final class NotSignUp extends SignUpState {}
final class NotVerified extends SignUpState {}
final class FirstTime extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;

  SignUpError({required this.message});
}

final class SignUpVisable extends SignUpState {
  final bool isVisable;

  SignUpVisable({required this.isVisable});
}
