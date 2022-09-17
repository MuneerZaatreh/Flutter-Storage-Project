import 'package:flutter_application_1/models/barcode.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _dbName = "Barcodes";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: ((db, version) async => await db.execute(
            "CREATE TABLE BARCODE (id integer PRIMARY KEY, integer code, integer amount)")),
        version: _version);
  }

  static Future<int> AddBarcode(Barcode barcode) async {
    final db = await _getDB();
    return await db.insert("Barcodes", barcode.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> RemoveBarcode(Barcode barcode) async {
    final db = await _getDB();
    return await db
        .delete("Barcodes", where: 'code = ?', whereArgs: [barcode.code]);
  }

  static Future<List<Barcode>?> getAllBarcodes() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Barcodes");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Barcode.fromJson(maps[index]));
  }
}
