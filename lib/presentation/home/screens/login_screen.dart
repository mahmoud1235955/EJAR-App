
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/home/widgets/textformfield_widget.dart';
import 'package:test_ejar/routes/routes.dart';
import '../../../constants/colors.dart';
import '../../../constants/extentions.dart';
import '../controllers/controllers copy/login/cubit/log_in_cubit.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: 10.edgeInsetsAll,
        child: Column(
          children: [
            50.gap,
            CircleAvatar(
              radius: 30,
              backgroundColor: appColors.darkBlueColor,
              child: Icon(
                Icons.person_outline_outlined,
                color: appColors.whiteColotr,
                size: 30,
              ),
            ),
            30.gap,
            Text(
              "LogIn",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: appColors.darkBlueColor,
              ),
            ),
            10.gap,
            BlocProvider(
              create: (context) => LogInCubit(),
              child: BlocBuilder<LogInCubit, LogInState>(
                builder: (context, state) {
                  return Form(
                    key: context.read<LogInCubit>().formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormFieldWidget(
                          prefixIcon: Icon(Icons.email_outlined),
                          lable: "Email",
                          hint: "Please Enter Your Email",
                          controller: context
                              .read<LogInCubit>()
                              .emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Email";
                            } else if (!value.contains("@")) {
                              return "Please Enter A Valid Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        20.gap,
                        TextFormFieldWidget(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: InkWell(
                            onTap: () {
                              context.read<LogInCubit>().changeVisable();
                            },
                            child: context.read<LogInCubit>().isVisable
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                          ),
                          lable: "Password",
                          hint: "Enter Your Password",
                          obsecureText: state is LogInvisible
                              ? state.isVisible
                              : true,
                          controller: context
                              .read<LogInCubit>()
                              .passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Password";
                            } //else if(){}
                          },
                        ),
                        10.gap,
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.forgot,
                                    (route) => false,
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.gap,
                        InkWell(
                          onTap: () {
                          context.read<LogInCubit>().logIn();
                          },
                          child: Container(
                            padding: 10.edgeInsetsAll,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: appColors.darkBlueColor,
                            ),
                            child: state is LogInLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "LogIn",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.whiteColotr,
                                    ),
                                  ),
                          ),
                        ),
                        15.gap,
                      ],
                    ),
                  );
                },
              ),
            ),
            10.gap,
            Row(
              children: [
                Expanded(child: Text("Don't have an account")),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.signUp,
                        (route) => false,
                      );
                    },
                    child: Text(
                      " Sign Up ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
