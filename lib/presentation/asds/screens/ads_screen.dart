import 'package:flutter/material.dart';
import 'package:test_ejar/routes/routes.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
         leading: IconButton(
        onPressed: () {
           Navigator.pushReplacementNamed(context, Routes.home);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
        title: const Text("Ads"),
      ),
    );
  }
}
