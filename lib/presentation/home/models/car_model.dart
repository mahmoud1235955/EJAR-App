class CarModel {
  final int id;
  final String ownerId;
  final String ownerName;
  final String carName;
  final String carBrand;
  final String carModel;
  final int? carYear;
  final int? kilometers;
  final String? fuelType;
  final String? gearType;
  final String? rentSystem;
  final String? carBody;
  final String? color;
  final String? description;
  final String? location;
  final String? imageUrl;
  final String? price;
  final String? contactPhone;
  final bool? availability;

  CarModel({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.carName,
    required this.carBrand,
    required this.carModel,
    required this.carYear,
    required this.kilometers,
    required this.fuelType,
    required this.gearType,
    required this.rentSystem,
    required this.carBody,
    required this.color,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.contactPhone,
    required this.availability,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      ownerId: json['ownerId']?.toString() ?? "",
      ownerName: json['ownerName']?.toString() ?? "",
      carName: json['carName']?.toString() ?? "",
      carBrand: json['carBrand']?.toString() ?? "",
      carModel: json['carModel']?.toString() ?? "",
      carYear: json['carYear'] is int
          ? json['carYear']
          : int.tryParse(json['carYear'].toString()) ?? 0,
      kilometers: json['kilometers'] is int
          ? json['kilometers']
          : int.tryParse(json['kilometers'].toString()) ?? 0,
      fuelType: json['fuelType']?.toString() ?? "",
      gearType: json['gearType']?.toString() ?? "",
      rentSystem: json['rentSystem']?.toString() ?? "",
      carBody: json['carBody']?.toString() ?? "",
      color: json['color']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
      location: json['location']?.toString() ?? "",
      imageUrl: json['imageUrl']?.toString() ?? "",
      price: json['price']?.toString() ?? "0",
      contactPhone: json['contactPhone']?.toString() ?? "",
      availability: json['availability'] is bool
          ? json['availability']
          : (json['availability']?.toString().toLowerCase() == "true"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerId": ownerId,
      "ownerName": ownerName,
      "carName": carName,
      "carBrand": carBrand,
      "carModel": carModel,
      "carYear": carYear,
      "kilometers": kilometers,
      "fuelType": fuelType,
      "gearType": gearType,
      "rentSystem": rentSystem,
      "carBody": carBody,
      "color": color,
      "description": description,
      "location": location,
      "imageUrl": imageUrl,
      "price": price,
      "contactPhone": contactPhone,
      "availability": availability,
    };
  }
}
