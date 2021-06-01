import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/pages/scan_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:pipe_reader_qr/src/utils/utils_scan.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScansById(scans[i].id);
              },
              child: ListTile(
                leading: Icon(
                  this.type == "http"
                      ? Icons.home_outlined
                      : Icons.map_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[i].value),
                subtitle: Text("Id: ${scans[i].id.toString()}"),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () => launchURL(context, scans[i]),
              ),
            ));
  }
}
