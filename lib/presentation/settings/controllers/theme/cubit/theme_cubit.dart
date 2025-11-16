import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_ejar/SharedPrefrances/shared_prefrances.dart';
import 'package:test_ejar/presentation/settings/theme/dark_theme.dart';
import 'package:test_ejar/presentation/settings/theme/light_them.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = "currentTheme";

  ThemeCubit() : super(ThemeInitial(themeData: lightTheme));

  /// تهيئة الثيم عند فتح التطبيق
  Future<void> initTheme() async {
    final currentTheme = SharedPref.getData(key: _themeKey) ?? "light";

    if (currentTheme == "dark") {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  /// تغيير الثيم وحفظه
  Future<void> changeTheme() async {
    if (state is ThemeDark) {
      await SharedPref.storeData(key: _themeKey, value: "light");
      emit(ThemeLight());
    } else {
      await SharedPref.storeData(key: _themeKey, value: "dark");
      emit(ThemeDark());
    }
  }
}
