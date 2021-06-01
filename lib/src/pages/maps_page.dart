import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/widgets/scan_tiles.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(type: "geo");
  }
}
