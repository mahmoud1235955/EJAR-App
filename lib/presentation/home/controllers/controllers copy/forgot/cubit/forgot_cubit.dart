import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/routes/routes.dart';
part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  void resetPassword() async {
    try {
      emit(ForgotLoading());
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Navigator.of(
        formKey.currentContext!,
      ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
      emit((ForgotSuccess()));
      "email has been sent successfully".showToast();
    } on FirebaseException catch (error) {
      "some thing went error".showToast;
      emit(ForgotError(message: error.message ?? "some thing went error"));
    } catch (error) {
      error.toString().showToast;
      emit(ForgotError(message: error.toString()));
    }
  }
}
