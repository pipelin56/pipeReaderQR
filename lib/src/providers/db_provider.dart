import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pipe_reader_qr/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._(); //private constructor

  DBProvider._();

  get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //path DB in device
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "ScanDB.db");
    print("path: $path");

    //version should upgrade when edit DB
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Scans(id INTEGER PRIMARY KEY, 
          type TEXT,
          value TEXT)''');
    });
  }

  Future<int> newScan(ScanModel scanModel) async {
    final db = await database;
    final result = await db.insert("Scans", scanModel.toJson());

    return result;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final res = await db.query("Scans");

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<List<dynamic>> getScanByType(String type) async {
    final db = await database;
    final res = await db.query("Scans", where: "type = ?", whereArgs: [type]);

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    final result = await db.insert("Scans", scanModel.toJson(),
        where: "id = ?", whereArgs: [scanModel.id]);

    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final result = await db.delete("Scans", where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final result = await db.delete("Scans");
    return result;
  }
}
