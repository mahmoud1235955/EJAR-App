import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/cubit/signup/sign_up_cubit.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/login/cubit/log_in_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(context.read<LogInCubit>(),context)..checkFirstTime(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if (state is FirstTime) {
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.onboarding, (route) => false);
          } else if (state is NormalSplash) {
            // تحقق من حالة تسجيل الدخول
            context.read<SignUpCubit>().checkSignUp(context);
          } else if (state is NotSignUp) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.signUp, (route) => false);
          } else if (state is SignUpsuccess) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          } else if (state is NotVerified) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
          } else if (state is LogInsuccess) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
