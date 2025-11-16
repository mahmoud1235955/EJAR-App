part of 'home_cubit.dart';

@immutable
abstract class HomeState {}


class SliderInitial extends HomeState {}

class SliderChanged extends HomeState {
  final int index;
  SliderChanged(this.index);
}