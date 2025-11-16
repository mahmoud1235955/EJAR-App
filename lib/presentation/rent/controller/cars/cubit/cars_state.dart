// ignore_for_file: non_constant_identifier_names

part of 'cars_cubit.dart';

@immutable
abstract class CarsState {}

@immutable
class CarsFormState extends CarsState {
  ContactEnum? contactValue;
  final TextEditingController phoneController;
  final TextEditingController imgLinkController;
  final TextEditingController versionCarController;
  final TextEditingController yearController;
  final TextEditingController kiloMeterController;
  final TextEditingController adNameController;
  final TextEditingController adDescController;
  final TextEditingController NameController;
  final TextEditingController Moneycontroller;
  final List<DropdownMenuItem<String>> carsList;
  final String selectedBrand;
  final CarEnum? selectedState;
  final List<String>? locationList;
  final List<DropdownMenuItem<String>> carBodyType;
  final String? selectedGear;
  final String? selectedRentSystem;
  final String? selectedCarBody;
  final String? selcteedTypeRent;
  final ContactEnum? selectedContact;
  final List<DropdownMenuItem<String>>? fuelType;
  final List<String> categories;
  final List<IconData>? icons;
  final String? fuelValue;
  bool checkBoxValue;

  CarsFormState({
    required this.selectedContact,
    required this.NameController,
    required this.icons,
    required this.categories,
    required this.contactValue,
    required this.phoneController,
    required this.checkBoxValue,
    required this.adNameController,
    required this.Moneycontroller,
    required this.adDescController,
    required this.fuelType,
    required this.fuelValue,
    required this.selcteedTypeRent,
    required this.selectedCarBody,
    required this.imgLinkController,
    required this.versionCarController,
    required this.yearController,
    required this.kiloMeterController,
    required this.carsList,
    required this.selectedBrand,
    required this.selectedState,
    required this.locationList,
    required this.selectedGear,
    required this.selectedRentSystem,
    required this.carBodyType,
  });

  CarsFormState copyWith({
    List<IconData>? icons,
    ContactEnum? contactValue,
    bool? checkBoxValue,
    List<String>? categories,
    TextEditingController? phoneController,
    TextEditingController? Moneycontroller,
    TextEditingController? imgLinkController,
    TextEditingController? versionCarController,
    TextEditingController? yearController,
    TextEditingController? kiloMeterController,
    List<DropdownMenuItem<String>>? carsList,
    List<DropdownMenuItem<String>>? fuelType,
    TextEditingController? NameController,
    TextEditingController? adNameController,
    TextEditingController? adDescController,
    String? fuelValue,
    String? selectedBrand,
    CarEnum? selectedState,
    String? selcteedTypeRent,
    List<String>? locationList,
    String? selectedGear,
    String? selectedRentSystem,
    List<DropdownMenuItem<String>>? carBodyType,
    String? selectedCarBody,
    ContactEnum? selectedContact,
  }) {
    return CarsFormState(
      selectedContact: selectedContact ?? this.selectedContact,
      NameController:
          NameController ?? this.NameController, // ✅ أول بارامتر positional
      icons: icons ?? this.icons,
      categories: categories ?? this.categories,
      contactValue: contactValue ?? this.contactValue,
      phoneController: phoneController ?? this.phoneController,
      checkBoxValue: checkBoxValue ?? this.checkBoxValue,
      adNameController: adNameController ?? this.adNameController,
      Moneycontroller: Moneycontroller ?? this.Moneycontroller,
      adDescController: adDescController ?? this.adDescController,
      fuelType: fuelType ?? this.fuelType,
      fuelValue: fuelValue ?? this.fuelValue,
      selcteedTypeRent: selcteedTypeRent ?? this.selcteedTypeRent,
      selectedCarBody: selectedCarBody ?? this.selectedCarBody,
      imgLinkController: imgLinkController ?? this.imgLinkController,
      versionCarController: versionCarController ?? this.versionCarController,
      yearController: yearController ?? this.yearController,
      kiloMeterController: kiloMeterController ?? this.kiloMeterController,
      carsList: carsList ?? this.carsList,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedState: selectedState ?? this.selectedState,
      locationList: locationList ?? this.locationList,
      selectedGear: selectedGear ?? this.selectedGear,
      selectedRentSystem: selectedRentSystem ?? this.selectedRentSystem,
      carBodyType: carBodyType ?? this.carBodyType,
    );
  }
}
