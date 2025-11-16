
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/home/widgets/textformfield_widget.dart';
import '../../../constants/colors.dart';
import '../../../constants/extentions.dart';
import '../controllers/controllers copy/forgot/cubit/forgot_cubit.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: 10.edgeInsetsAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                "Sign In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: appColors.darkBlueColor,
                ),
              ),
              10.gap,
              BlocProvider(
                create: (context) => ForgotCubit(),
                child: BlocBuilder<ForgotCubit, ForgotState>(
                  builder: (context, state) {
                    return Form(
                      key: context.read<ForgotCubit>().formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormFieldWidget(
                            prefixIcon: Icon(Icons.email_outlined),
                            lable: "Email",
                            hint: "Please Enter Your Email",
                            controller: context
                                .read<ForgotCubit>()
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
                          25.gap,
                          InkWell(
                            onTap: () {
                              context.read<ForgotCubit>().resetPassword();
                            },
                            child: Container(
                              padding: 10.edgeInsetsAll,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: appColors.darkBlueColor,
                              ),
                              child: state is ForgotLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Get Password",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: appColors.whiteColotr,
                                      ),
                                    ),
                            ),
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
      ),
    );
  }
}
