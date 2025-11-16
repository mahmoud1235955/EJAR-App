import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_ejar/constants/extentions.dart';

class Sqflite {
  Database? _database;
  Future<Database?> get database async {
    _database ??= await initDatabase();
    return _database;
  }

  Future<Database?> initDatabase() async {
    try {
      final path = await getDatabasesPath();
      final fullPath = '$path/database.db';

      return openDatabase(
        fullPath,
        version: 1,
        onCreate: (db, version) async {
          return await db.execute('''
CREATE TABLE IF NOT EXISTS "ejar" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "imglink"	TEXT NOT NULL,
  "brandname"	TEXT NOT NULL,
  "version"	INTEGER NOT NULL,
  "year" INTEGER NOT NULL,
  "kilometer" INTEGER NOT NULL,
  "fuel" TEXT NOT NULL,
  "gear" TEXT NOT NULL,
  "rentsystem" TEXT NOT NULL,
  "renttype" TEXT NOT NULL,
  "carbody" TEXT NOT NULL,
  "price" INTEGER NOT NULL,
  "phone" INTEGER NOT NULL,
  "adname" TEXT NOT NULL,
  "adDesc" TEXT NOT NULL,
  "location" TEXT NOT NULL,
  "yourname" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "contact" TEXT NOT NULL
)
''');
        },
      );
    } catch (e) {
      e.toString().showToast;
    }
  }

  //drop table
  Future<void> dropData() async {
    try {
      final path = await getDatabasesPath();
      final fullPath = '$path/database.db';
      await deleteDatabase(fullPath);
    } catch (e) {
      e.toString().showToast;
    }
  }

  //CRUD operations
  Future<int> createData(String sql, List<Object?> list) async {
    try {
      Database? mydb = await database;
      int response = await mydb!.rawInsert(sql);
      return response;
    } catch (e) {
      e.toString().showToast;
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    try {
      Database? mydb = await database;
      List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
      return response;
    } catch (e) {
      e.toString().showToast;
      return [];
    }
  }

  Future<bool> updateData(String sql, List<Object?> list) async {
    try {
      Database? mydb = await database;
      int response = await mydb!.rawUpdate(sql);
      return response >= 0 ? true : false;
    } catch (e) {
      e.toString().showToast;
      return false;
    }
  }

  Future<bool> deleteData(String sql,) async {
    try {
      Database? mydb = await database;
      int response = await mydb!.rawDelete(sql);
      return response > 0 ? true : false;
    } catch (e) {
      e.toString().showToast;
      return false;
    }
  }
}
