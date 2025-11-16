import 'dart:async' show Timer;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:test_ejar/presentation/account/routes/account_navbar_routes.dart';
import 'package:test_ejar/presentation/asds/routes/ads_navbar_route.dart';
import 'package:test_ejar/presentation/chats/routes/navBar/chat_navbar_route.dart';
import 'package:test_ejar/presentation/settings/routes/settings_nav_screen.dart';
import 'package:test_ejar/routes/routes.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late Timer timer;
  late PageController pageController;
  int currentIndex = 0;
  int sliderLength = 0;
  int bottomNavIndex = 0;
  HomeCubit() : super(SliderInitial()) {
    pageController = PageController();
  }

  void setSliderLength(int length) {
    sliderLength = length;
  }

  void startAutoSlide() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (sliderLength == 0) return;
      currentIndex = (currentIndex + 1) % sliderLength;

      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      emit(SliderChanged(currentIndex));
    });
  }

  void changePage(int index) {
    currentIndex = index;
    emit(SliderChanged(currentIndex));
  }

  @override
  Future<void> close() {
    timer.cancel();
    pageController.dispose();
    return super.close();
  }

  List<String> bottomNavRoutes = [
    Routes.home,
    AdsNavbarRoute.adsNav,
    Routes.home,
    AccountNavbarRoutes.accountNav,
    SettingsNavScreen.settingsNav,

    //ChatNavbarRoute.chatNav,
  ];

  void bottomNav(
    int index,
    List<String> bottomNavRoutes,
    BuildContext context,
  ) {
    {
      bottomNavIndex = index;
      Navigator.pushReplacementNamed(context, bottomNavRoutes[index]);
      emit(bottomNavChanged(currentIndex, bottomNavRoutes[index]));
    }
  }
}
