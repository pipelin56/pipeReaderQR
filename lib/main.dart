import 'package:flutter/material.dart';
import 'package:pipe_reader_qr/src/pages/home_page.dart';
import 'package:pipe_reader_qr/src/pages/map_page.dart';
import 'package:pipe_reader_qr/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new UiProvider()),
        ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: "home",
        routes: {"home": (_) => HomePage(), "map": (_) => MapPage()},
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
      ),
    );
  }
}
