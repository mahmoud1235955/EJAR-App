import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_ejar/presentation/home/models/car_model.dart';
import 'package:test_ejar/sqflite/sqflite.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial()) {
    readData();
  }

  Future<void> readData() async {
    emit(CarsLoadingState());
    try {
      final db = Sqflite();
      final rawData = await db.readData("SELECT * FROM ejar");

      // تحويل البيانات من Map -> CarModel
      final carsData = rawData.map<CarModel>((car) {
        return CarModel.fromJson(car); // أو fromMap لو عاملها مخصوص للـ SQL
      }).toList();

      emit(CarsLoadedState(carsData));
    } catch (e) {
      emit(CarsErrorState(e.toString()));
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final db = Sqflite();
      await db.deleteData("DELETE FROM ejar WHERE id = $id");
      readData();
    } catch (e) {
      emit(CarsErrorState(e.toString()));
    }
  }

  Future<void> updateData(CarModel car,int index) async {
    try {
      final db = Sqflite();

      await db.updateData('''
      UPDATE ejar SET
        owner = '${car.ownerId}',
        carName = '${car.carName}',
        carBrand = '${car.carBrand}',
        carModel = '${car.carModel}',
        carYear = ${car.carYear},
        kilometers = ${car.kilometers},
        fuelType = '${car.fuelType}',
        gearType = '${car.gearType}',
        rentSystem = '${car.rentSystem}',
        carBody = '${car.carBody}',
        color = '${car.color}',
        description = '${car.description}',
        imageUrl = '${car.imageUrl}',
        price = '${car.price}',
        contactPhone = '${car.contactPhone}',
       
      WHERE id = $index
    ''', []);

      // بعد التحديث نعمل إعادة قراءة علشان الـ UI يتحدث
      await readData();
    } catch (e) {
      emit(CarsErrorState(e.toString()));
    }
  }
}
