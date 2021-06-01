import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/pages/directions_page.dart';
import 'package:pipe_reader_qr/src/pages/maps_page.dart';
import 'package:pipe_reader_qr/src/pages/scan_list_provider.dart';
import 'package:pipe_reader_qr/src/providers/ui_provider.dart';
import 'package:pipe_reader_qr/src/widgets/custom_navigation_bar.dart';
import 'package:pipe_reader_qr/src/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Historial"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteAllScans();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Get current selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt; //default

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType("geo");
        return MapsPage();
      case 1:
        scanListProvider.loadScansByType("http");
        return DirectionsPage();
      default:
        return MapsPage();
    }
  }
}
