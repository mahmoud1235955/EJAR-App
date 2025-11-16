import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  brightness: Brightness.dark,
  primaryColor: Colors.white,
);
