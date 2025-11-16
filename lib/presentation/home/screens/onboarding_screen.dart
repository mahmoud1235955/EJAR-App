
import 'package:flutter/material.dart';
import 'package:test_ejar/presentation/home/widgets/custom_onboarding_screen.dart';
import 'package:test_ejar/routes/routes.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, Routes.signUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EJAR', style: TextStyle(fontSize: 24)),
        backgroundColor: Color(0xff544d80),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          CustomOnboardingWidget(
            title: 'Welcome to Ejar',
            description:
                'Rent and lease apartments, cars, and more — all in one place.',
            imagePath: 'assets/img/thumbnail.png',
            onNext: _nextPage,
            buttonText: 'Next',
          ),
          CustomOnboardingWidget(
            buttonText: 'Next',
            title: 'Easy Search',
            description:
                'Find what you need quickly with smart filters by location, price, and category.',
            imagePath: 'assets/img/thumbnail2.png',
            onNext: _nextPage,
          ),
          CustomOnboardingWidget(
            buttonText: 'Get Started',
            title: 'Fast & Direct Contact',
            description:
                'Connect instantly with owners and start your rental journey today.',
            imagePath: 'assets/img/thumbnail3.png',
            onNext: _nextPage,
          ),
        ],
      ),
    );
  }
}
