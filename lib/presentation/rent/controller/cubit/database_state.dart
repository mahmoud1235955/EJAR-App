part of 'database_cubit.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}
class CarsLoadingState extends DatabaseState {}

class CarsLoadedState extends DatabaseState {
  final List<CarModel> cars;
  CarsLoadedState(this.cars);
}

class CarsErrorState extends DatabaseState {
  final String message;
  CarsErrorState(this.message);
}
