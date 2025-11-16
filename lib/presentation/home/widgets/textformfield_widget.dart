import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Widget ?prefixIcon;
  final String lable;
  final String hint;
  final Widget? suffixIcon;
  final bool? obsecureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFormFieldWidget({
    this.suffixIcon,
    super.key,
     this.prefixIcon,
    required this.lable,
    required this.hint,
     this.obsecureText,
    required this.controller,
     this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: appColors.darkBlueColor,
      obscureText: obsecureText ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: lable,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appColors.darkBlueColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appColors.darkBlueColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appColors.darkBlueColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appColors.redColor),
        ),
      ),
    );
  }
}
