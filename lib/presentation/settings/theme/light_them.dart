import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.lightGreenAccent,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    ),
  brightness: Brightness.light,
  primaryColor: Colors.white,
);