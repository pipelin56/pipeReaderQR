import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/widgets/scan_tiles.dart';

class DirectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(type: "http");
  }
}
