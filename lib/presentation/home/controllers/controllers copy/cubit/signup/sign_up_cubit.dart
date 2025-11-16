import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_ejar/SharedPrefrances/shared_prefrances.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/login/cubit/log_in_cubit.dart';
import 'package:test_ejar/routes/routes.dart';
part 'sign_up_state.dart';
class SignUpCubit extends Cubit<SignUpState> {
   LogInCubit logInCubit = LogInCubit();
  SignUpCubit(this.logInCubit, BuildContext context) : super(SignUpInitial());

  bool isVisable = false;
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void changeVisable() {
    isVisable = !isVisable;
    emit(SignUpVisable(isVisable: isVisable));
  }
  /// ✅ SignUp User
  Future<void> signup(BuildContext context) async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        emit(SignUpLoading());

        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // إنشاء حساب جديد
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // إرسال إيميل التفعيل
        
        await userCredential.user?.sendEmailVerification();
        // حفظ بيانات المستخدم في Firestore
        await firestore.collection("users").doc(userCredential.user?.uid).set({
          "email": emailController.text.trim(),
          "name": nameController.text.trim(),
          "uid": userCredential.user?.uid,
        });

        // تسجيل الخروج
        //await firebaseAuth.signOut();

        // الانتقال لصفحة تسجيل الدخول
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );

        emit(SignUpsuccess());
      }
    } on FirebaseAuthException catch (error) {
      error.message.toString().showToast;
      emit(SignUpError(message: error.message ?? "Something went wrong"));
    } catch (error) {
      error.toString().showToast;
      emit(SignUpError(message: error.toString()));
    }
  }

  /// ✅ Check First Time Opening
  Future<void> checkFirstTime() async {
    final isFirstTime = await SharedPref.getData(key: "isFirstTime");
    if (isFirstTime == null) {
      await SharedPref.storeData(key: "isFirstTime", value: false);
      emit(FirstTime());
    } else {
      emit(NormalSplash());
    }
  }

  /// ✅ Check If User Already Signed Up
  void checkSignUp(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(NotSignUp());
    } else {
      if (user.emailVerified) {
        emit(SignUpsuccess());
      } else {
        emit(NotVerified());
      }
    }
  }
void checkLogin(BuildContext context) async{
  
}
  /// ✅ Logout User
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await SharedPref.removeData(key: "isFirstTime");
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
    emit(NotSignUp());
  }
}
