// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';
import 'package:test_ejar/presentation/rent/enum/contact_enum.dart';
import 'package:test_ejar/routes/routes.dart';
import '../../../../home/models/car_model.dart';
import '../../../enum/car_enum.dart';
import '../../../screens/cars_screen.dart';
import '../../../screens/home_repair_screen.dart';
import '../../../screens/real_estate_screen.dart';
import '../../../screens/smart_equipment_screen.dart';
part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  ChatsCubit? chatsCubit;
  CarsCubit(this.chatsCubit)
    : super(
        CarsFormState(
          NameController: TextEditingController(),
          imgLinkController: TextEditingController(),
          versionCarController: TextEditingController(),
          yearController: TextEditingController(),
          kiloMeterController: TextEditingController(),
          carsList: [],
          selectedBrand: "",
          selectedState: null,
          locationList: [],
          selectedGear: null,
          selectedRentSystem: null,
          carBodyType: [],
          selectedCarBody: null,
          selcteedTypeRent: null,
          fuelType: [],
          fuelValue: '',
          adNameController: TextEditingController(),
          adDescController: TextEditingController(),
          Moneycontroller: TextEditingController(),
          checkBoxValue: true,
          phoneController: TextEditingController(),
          contactValue: ContactEnum.phone,
          categories: [],
          icons: [],
          selectedContact: ContactEnum.phone,
        ),
      ) {
    _initBrands();
    carBody();
    fuelTypes();
  }
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final List<CarModel> carsList = [];
  void getContact(ContactEnum contactValue) {
    if (state is CarsFormState) {
      final currentState = state as CarsFormState;
      emit(
        currentState.copyWith(
          selectedContact: contactValue,
          contactValue: contactValue,
        ),
      );
    }
  }

  void publishCar() {
    if (state is CarsFormState &&
        (globalKey.currentState?.validate() ?? false)) {
      final currentState = state as CarsFormState;
      final car = CarModel(
        ownerName: currentState.NameController!.text,
        carName: currentState.adNameController.text,
        description: currentState.adDescController.text,
        carBrand: currentState.selectedBrand,
        carModel: currentState.versionCarController.text,
        carYear: int.tryParse(currentState.yearController.text),
        kilometers: int.tryParse(currentState.kiloMeterController.text),
        fuelType: currentState.fuelValue,
        gearType: currentState.selectedGear,
        rentSystem: currentState.selectedRentSystem,
        carBody: currentState.selectedCarBody,
        color: "",
        imageUrl: currentState.imgLinkController.text,
        price: currentState.Moneycontroller.text,
        contactPhone: currentState.phoneController.text,
        availability: currentState.checkBoxValue,
        id: 0,
        ownerId: "",
        location: '',
      );

      carsList.add(car);

      emit(
        currentState.copyWith(
          fuelType: currentState.fuelType,
          carsList: currentState.carsList,
          selectedBrand: currentState.selectedBrand,
          selectedState: currentState.selectedState,
          locationList: currentState.locationList,
          selectedGear: currentState.selectedGear,
          selectedRentSystem: currentState.selectedRentSystem,
          carBodyType: currentState.carBodyType,
          selectedCarBody: currentState.selectedCarBody,
          selcteedTypeRent: currentState.selcteedTypeRent,
          fuelValue: currentState.fuelValue,
          adNameController: currentState.adNameController,
          adDescController: currentState.adDescController,
          Moneycontroller: currentState.Moneycontroller,
          checkBoxValue: currentState.checkBoxValue,
          phoneController: currentState.phoneController,
          contactValue: currentState.contactValue,
          categories: currentState.categories,
          icons: currentState.icons,
          selectedContact: currentState.selectedContact,
          NameController: currentState.NameController,
          imgLinkController: currentState.imgLinkController,
          versionCarController: currentState.versionCarController,
          yearController: currentState.yearController,
          kiloMeterController: currentState.kiloMeterController,
        ),
      ); // يعمل refresh للـ UI
    }
  }

  List<String> categoriesList = [
    "سيارات",
    "عقارات",
    "معدات ذكية",
    "اصلاحات منزلية",
  ];

  final List<String> screens = [
    Routes.carsView,
    Routes.realEstateView,
    Routes.smartEquipment,
    Routes.homeRepairView,
  ];

  final List<String> fuelType = [
    "بنزين",
    "ديزل",
    "كهرباء",
    "هايبرد",
    "غاز طبيعي",
    "غاز بترولي مسال (LPG)",
    "غاز طبيعي مضغوط (CNG)",
    "كهرباء + بنزين (Plug-in Hybrid)",
    "كهرباء + ديزل (Plug-in Hybrid Diesel)",
    "كهرباء + غاز طبيعي (Plug-in Hybrid CNG)",
    "كهرباء + غاز بترولي مسال (Plug-in Hybrid LPG)",
    "كهرباء + هيدروجين (Fuel Cell Electric Vehicle - FCEV)",
    "كهرباء + سولار (Solar Electric Vehicle)",
    "كهرباء + طاقة نووية (Nuclear Electric Vehicle)",
    "كهرباء + طاقة متجددة أخرى",
    "اخرى",
  ];

  void fuelTypes() {
    final currentState = state as CarsFormState;
    final items = fuelType
        .map((fuel) => DropdownMenuItem<String>(value: fuel, child: Text(fuel)))
        .toList();
    emit(currentState.copyWith(fuelType: items));
  }

  void updateFuelType(String fuelValue) {
    if (state is CarsFormState &&
        (globalKey.currentState?.validate() ?? false)) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(fuelValue: fuelValue));
    }
  }

  void checkBoxChanged(bool? value) {
    if (state is CarsFormState &&
        (globalKey.currentState?.validate() ?? false)) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(checkBoxValue: value ?? false));
    }
  }

  void checkBoxChanged2(bool? value) {
    if (state is CarsFormState &&
        (globalKey.currentState?.validate() ?? false)) {
      final currentState = state as CarsFormState;
      currentState.checkBoxValue = value ?? false;
      emit(currentState.copyWith(checkBoxValue: !currentState.checkBoxValue));
    }
  }

  Future<void> saveCarToDB(CarsFormState formState) async {
    final car = {
      "brand": formState.selectedBrand,
      "version": formState.versionCarController.text,
      "state": formState.selectedState?.toString() ?? "",
      "km": formState.selectedState == CarEnum.NotNew
          ? formState.kiloMeterController.text
          : "0",
      "year": formState.yearController.text,
      "imgLink": formState.imgLinkController.text,
    };
  }

  List<IconData> iconsList = [
    Icons.directions_car,
    Icons.home,
    Icons.smartphone,
    Icons.build,
  ];

  final List<String> carBrands = [
    "Toyota",
    "Honda",
    "Nissan",
    "Hyundai",
    "Kia",
    "Mitsubishi",
    "Mazda",
    "Suzuki",
    "Subaru",
    "Ford",
    "Chevrolet",
    "Jeep",
    "BMW",
    "Mercedes-Benz",
    "Audi",
    "Volkswagen",
    "Porsche",
    "Lamborghini",
    "Ferrari",
    "Tesla",
  ];

  List<String> egyptCities = [
    "القاهرة",
    "الجيزة",
    "حلوان",
    "العبور",
    "الشروق",
    "بدر",
    "أكتوبر",
    "الشيخ زايد",
    "الإسكندرية",
    "البحيرة",
    "الدقهلية",
    "الغربية",
    "كفر الشيخ",
    "المنوفية",
    "الشرقية",
    "دمياط",
    "بورسعيد",
    "الإسماعيلية",
    "السويس",
    "الفيوم",
    "بني سويف",
    "المنيا",
    "أسيوط",
    "سوهاج",
    "قنا",
    "الأقصر",
    "أسوان",
    "شمال سيناء",
    "جنوب سيناء",
    "البحر الأحمر",
    "مطروح",
    "الوادي الجديد",
  ];

  List<String> carBodyType = [
    "سيدان",
    "هاتشباك",
    "كروس أوفر",
    "SUV",
    "بيك أب",
    "فان",
    "كوبيه",
    "كونفيرتبل",
    "ستيشن واجن",
    "ميكروباص",
    "ليموزين",
    "رودستر",
    "بيك أب مزدوج",
    "بيك أب مفرد",
    "شاحنة خفيفة",
    "شاحنة ثقيلة",
    "ميني فان",
    "جيب",
    "كابريوليه",
    "كومبي",
    "تريلر",
    "شاحنة نقل",
    "شاحنة مبردة",
    "شاحنة قلاب",
    "شاحنة صهريج",
    "شاحنة نقل حاويات",
    "شاحنة نقل مواد خطرة",
    "شاحنة نقل معدات ثقيلة",
    "شاحنة نقل نفايات",
    "شاحنة نقل مواد بناء",
    "شاحنة نقل أثاث",
    "شاحنة نقل سيارات",
    "شاحنة نقل أغنام",
    "شاحنة نقل دواجن",
    "شاحنة نقل مواشي",
    "شاحنة نقل بضائع عامة",
    "شاحنة نقل مواد غذائية",
    "شاحنة نقل مواد زراعية",
    "شاحنة نقل مواد كيميائية",
    "شاحنة نقل مواد نفطية",
    "شاحنة نقل مواد معدنية",
    "شاحنة نقل مواد بلاستيكية",
    "شاحنة نقل مواد ورقية",
    "شاحنة نقل مواد إلكترونية",
    "شاحنة نقل مواد طبية",
    "شاحنة نقل مواد تعليمية",
    "شاحنة نقل مواد رياضية",
    "شاحنة نقل مواد ترفيهية",
    "شاحنة نقل مواد سياحية",
    "شاحنة نقل مواد ثقافية",
    "شاحنة نقل مواد دينية",
    "شاحنة نقل مواد فنية",
    "شاحنة نقل مواد موسيقية",
    "شاحنة نقل مواد تصويرية",
    "شاحنة نقل مواد سينمائية",
    "شاحنة نقل مواد إذاعية",
    "شاحنة نقل مواد تلفزيونية",
    "شاحنة نقل مواد صحفية",
    "شاحنة نقل مواد إعلانية",
    "شاحنة نقل مواد تسويقية",
    "اخرى",
  ];

  void carBody() {
    final currentState = state as CarsFormState;
    final items = carBodyType
        .map(
          (bodyType) =>
              DropdownMenuItem<String>(value: bodyType, child: Text(bodyType)),
        )
        .toList();
    emit(currentState.copyWith(carBodyType: items));
  }

  void updateCarBody(String value) {
    if (state is CarsFormState) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selectedCarBody: value));
    }
  }

  void updateTypeRent(String value) {
    if (state is CarsFormState) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selcteedTypeRent: value));
    }
  }

  void _initBrands() {
    final currentState = state as CarsFormState;
    final items = carBrands
        .map(
          (brand) => DropdownMenuItem<String>(value: brand, child: Text(brand)),
        )
        .toList();

    emit(
      currentState.copyWith(carsList: items, selectedBrand: carBrands.first),
    );
  }

  void selectLocation(String value) {
    if (globalKey.currentState?.validate() ?? false) {
      final currentState = state as CarsFormState;
      emit(
        currentState.copyWith(
          locationList: [...currentState.locationList ?? [], value],
        ),
      );
    }
  }

  void selectCarBrand(String value) {
    if (globalKey.currentState?.validate() ?? false) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selectedBrand: value));
    }
  }

  void setSelectedState(CarEnum carState) {
    if (globalKey.currentState?.validate() ?? false) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selectedState: carState));
    }
  }

  void gearState(String gearState) {
    if (globalKey.currentState?.validate() ?? false) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selectedGear: gearState));
    }
  }

  void rentSystem(String rentSystem) {
    if (globalKey.currentState?.validate() ?? false) {
      final currentState = state as CarsFormState;
      emit(currentState.copyWith(selectedRentSystem: rentSystem));
    }
  }

  Widget currentScreen(int index) {
    switch (index) {
      case 0:
        return const CarsScreen();
      case 1:
        return const RealEstateScreen();
      case 2:
        return const SmartEquipmentScreen();
      case 3:
        return const HomeRepairScreen();
      default:
        return const CarsScreen();
    }
  }

  @override
  Future<void> close() {
    final s = state as CarsFormState;
    s.imgLinkController.dispose();
    s.versionCarController.dispose();
    s.yearController.dispose();
    s.kiloMeterController.dispose();
    s.adNameController.dispose();
    s.adDescController.dispose();
    s.Moneycontroller.dispose();
    s.phoneController.dispose();
    s.NameController.dispose();
    return super.close();
  }
}
