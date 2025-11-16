part of 'home_cubit.dart';

@immutable
abstract class HomeState {}


class SliderInitial extends HomeState {}

class SliderChanged extends HomeState {
  final int index;
  SliderChanged(this.index);
}
class bottomNavChanged extends HomeState {
  final int index;
  String routes;
  bottomNavChanged(this.index,this.routes);
}