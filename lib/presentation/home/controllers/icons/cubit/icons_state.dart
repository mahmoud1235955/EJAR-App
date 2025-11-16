part of 'icons_cubit.dart';

@immutable
abstract class IconsState {}

final class IconsInitial extends IconsState {}

final class IconsLoaded extends IconsState {
  Icon icon;
  String iconName;
  IconsLoaded({required this.icon,required this.iconName});
  
}
