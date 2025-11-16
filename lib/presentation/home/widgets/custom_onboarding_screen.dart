import 'package:flutter/material.dart';

import '../../../constants/extentions.dart';

class CustomOnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onNext;
  final String buttonText;
  const CustomOnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onNext,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            10.gap,
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            20.gap,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff544d80),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}
