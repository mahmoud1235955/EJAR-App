import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/presentation/home/models/car_model.dart';
import 'package:test_ejar/presentation/rent/controller/cars/cubit/cars_cubit.dart';
import 'package:test_ejar/presentation/rent/enum/contact_enum.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _carsSubscription;

  /// إضافة عربية جديدة
  Future<void> addProduct(CarsState state, int index) async {
    try {
      emit(AddProductLoading());

      if (state is! CarsFormState) {
        emit(AddProductError("No form data available"));
        return;
      }

      final String currentUserId = firebaseAuth.currentUser!.uid;

      /// بناء البيانات من الـ form state
      CarModel carData = CarModel(
        id: 0,
        ownerId: currentUserId,
        ownerName: state.NameController.text,
        carName: state.adNameController.text,
        carBrand: state.selectedBrand,
        carModel: state.versionCarController.text,
        carYear: int.parse(state.yearController.text),
        kilometers: int.tryParse(state.kiloMeterController.text) ?? 0,
        fuelType: state.fuelValue ?? "",
        gearType: state.selectedGear ?? "",
        rentSystem: state.selectedRentSystem ?? "",
        carBody: state.selectedCarBody,
        color: "",
        description: state.adDescController.text,
        location: state.locationList.toString(),
        imageUrl: state.imgLinkController.text,
        price: state.Moneycontroller.text,
        contactPhone: state.phoneController.text,
        availability: null,
      );

      /// رفع البيانات إلى Firestore
      await firestore.collection("AllCars").doc().set(carData.toJson());
      emit(AddProductLoaded());
      getCarsStream();
    } on FirebaseException catch (e) {
      e.message.toString().showToast;
      emit(AddProductError(e.toString()));
    } catch (e) {
      e.toString().showToast;
      emit(AddProductError(e.toString()));
    }
  }

  /// Stream لجلب العربيات
  void getCarsStream() {
    emit(AddProductLoading());

    _carsSubscription = firestore
        .collection("AllCars")
        .snapshots()
        .listen(
          (snapshot) {
            final cars = snapshot.docs
                .map(
                  (doc) =>
                      CarModel.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();

            emit(AddProductSuccess(cars));
          },
          onError: (e) {
            e.toString().showToast;
            emit(AddProductError(e.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _carsSubscription?.cancel();
    return super.close();
  }
}
