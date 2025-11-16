// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
extension sizedBoxExtension on num {
  SizedBox get gap=> SizedBox(height:toDouble(),width:toDouble() );
}extension edgeInsetsExtension on num {
  EdgeInsets get edgeInsetsAll => EdgeInsets.all(toDouble());
}
extension toastExtension on String {
Future<bool?> showToast()=>Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
