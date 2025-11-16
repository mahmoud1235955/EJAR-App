
import 'package:flutter/material.dart';

class HomeRepairScreen extends StatelessWidget {
  const HomeRepairScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Ad your Home Repair",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
    ));
  }
}