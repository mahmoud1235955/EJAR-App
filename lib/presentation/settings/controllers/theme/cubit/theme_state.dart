part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeData themeData;
  const ThemeState({required this.themeData});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.themeData});
}

final class ThemeLight extends ThemeState {
  ThemeLight() : super(themeData: lightTheme);
}

final class ThemeDark extends ThemeState {
  ThemeDark() : super(themeData: darkTheme);
}
