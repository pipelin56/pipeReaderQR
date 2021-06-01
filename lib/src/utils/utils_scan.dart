import 'package:flutter/cupertino.dart';
import 'package:pipe_reader_qr/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scanModel) async {
  final url = scanModel.value;
  if (scanModel.type == "http") {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, "map", arguments: scanModel);
  }
}
