import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pipe_reader_qr/src/pages/scan_list_provider.dart';
import 'package:pipe_reader_qr/src/utils/utils_scan.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.filter_center_focus),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#3D8BEF", "Cancel", false, ScanMode.QR);

          if (barcodeScanRes == "-1") {
            return;
          }

          final scanListProvider = //listen to false because we are in a function
              Provider.of<ScanListProvider>(context, listen: false);

          final scanModel = await scanListProvider.newScan(barcodeScanRes);
          launchURL(context, scanModel);
        });
  }
}
