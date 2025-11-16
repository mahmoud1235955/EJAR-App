import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  DropDownWidget({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.items,
    this.hintText,
    this.value,
  });
  DropDownWidget.form({
    Key? key,
    required String labelText,
    required void Function(T?)? onChanged,
    required List<DropdownMenuItem<T>>? items,
    String? hintText,
    required value,
  }) : this(
         key: key,
         labelText: labelText,
         onChanged: onChanged,
         items: items,
         hintText: hintText,
       );

  final String labelText;
  final void Function(T?)? onChanged;
  List<DropdownMenuItem<T>>? items =[
    
  ];
  final String? hintText;
  final T? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      items: items,
      onChanged: onChanged,
    );
    
  }
}
