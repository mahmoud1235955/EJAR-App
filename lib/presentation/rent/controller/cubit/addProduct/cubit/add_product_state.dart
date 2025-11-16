part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

final class AddProductInitial extends AddProductState {}
final class AddProductLoading extends AddProductState {}
final class AddProductLoaded extends AddProductState {
}
final class AddProductSuccess extends AddProductState {
  List<CarModel> product;

  AddProductSuccess(this.product);
}
final class AddProductError extends AddProductState {
  String error;
  AddProductError(this.error);
}