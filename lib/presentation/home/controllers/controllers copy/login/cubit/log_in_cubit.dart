import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/routes/routes.dart';
part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisable = true;
  void changeVisable() {
    isVisable = !isVisable;
    emit(LogInvisible(isVisible: isVisable));
  }

  void logIn() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        emit(LogInLoading());
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (firebaseAuth.currentUser!.emailVerified) {
          Navigator.of(
            formKey.currentContext!,
          ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          emit(LogInsuccess());
        } else {
          await firebaseAuth.signOut();
          "Please verify your email".showToast();
          emit(LogInError(errorMessage: "Please verify your email"));
        }
        emit(LogInsuccess());
      }
    } on FirebaseException catch (error) {
      'An error occurred'.showToast;
      emit(LogInError(errorMessage: error.message ?? 'An error occurred'));
    } catch (error) {
      error.toString().showToast;
      emit(LogInError(errorMessage: error.toString()));
    }
  }

  void checkLogin(BuildContext context) async{
   final user=FirebaseAuth.instance.currentUser;
   if(user!=null){
     if(user.emailVerified){
       emit(LogInsuccess());
     }else{
       emit(LogInError(errorMessage: "Please verify your email"));
     }
   }
  }
}
