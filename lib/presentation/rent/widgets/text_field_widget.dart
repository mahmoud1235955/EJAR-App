import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.maxLines,
    this.prefixIcon,
    this.prefix,
    required this.keyboardType,
  });
  const TextFieldWidget.form({
    Key? key,
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? prefix,
    int? maxLines,
    TextInputType? keyboardType,
  }) : this(
         key: key,
         controller: controller,
         labelText: labelText,
         hintText: hintText,
         suffixIcon: suffixIcon,
         prefix: prefix,
         maxLines: maxLines,
         prefixIcon: prefixIcon,
         keyboardType: keyboardType ?? TextInputType.text,
       );
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        prefix: prefix,
        prefixIcon: prefixIcon,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      controller: controller,
    );
  }
}
