class CarsModel {
  String? category;
  final String imageUrl;
  final String carName;
  final String carPrice;
  String? cardescription;
  String? model;
  String? color;
  String? location;
  String? petrol;
  int? numberOfSeats;
  int? rentdayes;
  String? bodyType;

  CarsModel(
    this.cardescription,
    this.category,
    this.model,
    this.location,
    this.numberOfSeats,
    this.petrol,
    this.rentdayes,
    this.bodyType,
    this.color, {
    required this.imageUrl,
    required this.carName,
    required this.carPrice,
  });
}
