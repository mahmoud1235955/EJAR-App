import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/login/cubit/log_in_cubit.dart';
import 'package:test_ejar/presentation/home/widgets/textformfield_widget.dart';
import 'package:test_ejar/routes/routes.dart'; 
import '../../../constants/colors.dart';
import '../../../constants/extentions.dart';
import '../controllers/controllers copy/cubit/signup/sign_up_cubit.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              "Sign Up",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: appColors.darkBlueColor,
              ),
            ),
            10.gap,
            BlocProvider(
              create: (context) => SignUpCubit(context.read<LogInCubit>(),context),
              child: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return Form(
                    key: context.read<SignUpCubit>().formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Name";
                            } else if (value.length < 4) {
                              return "please enter a valid name";
                            } else {
                              return null;
                            }
                          },

                          prefixIcon: Icon(Icons.person),
                          lable: "Name",
                          hint: "Enter Your Name",
                          controller: context
                              .read<SignUpCubit>()
                              .nameController,
                        ),
                        20.gap,
                        TextFormFieldWidget(
                          prefixIcon: Icon(Icons.email_outlined),
                          lable: "Email",
                          hint: "Please Enter Your Email",
                          controller: context
                              .read<SignUpCubit>()
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
                              context.read<SignUpCubit>().changeVisable();
                            },
                            child: context.read<SignUpCubit>().isVisable
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                          ),
                          lable: "Password",
                          hint: "Enter Your Password",
                          obsecureText: state is SignUpVisable
                              ? state.isVisable
                              : true,
                          controller: context
                              .read<SignUpCubit>()
                              .passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your Password";
                            } //else if(){}
                          },
                        ),
                        20.gap,
                        InkWell(
                          onTap: () {
                            context.read<SignUpCubit>().signup(context);
                          },
                          child: Container(
                            padding: 10.edgeInsetsAll,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: appColors.darkBlueColor,
                            ),
                            child: state is SignUpLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.whiteColotr,
                                    ),
                                  ),
                          ),
                        ),
                        10.gap,
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Text("Already have an accouunt"),
                            ),
                            10.gap,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.login,
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  "Sign In ?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
