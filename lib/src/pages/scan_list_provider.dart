import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/models/scan_model.dart';
import 'package:pipe_reader_qr/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = "http";

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    newScan.id = await DBProvider.db.newScan(newScan);

    if (this.selectedType == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScan();
    this.scans = [...scans]; //clear scans and add all scans load from db
    notifyListeners();
  }

  loadScansByType(String type) async {
    final futureScans = await DBProvider.db.getScanByType(type);
    this.scans = [...futureScans];
    this.selectedType = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteScansById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
