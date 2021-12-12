import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ConnectionDB().createDB();
    return MaterialApp(
      title: 'Se Der a Gente Passa',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Quicksand',
      ),
      home: MainScreen(),
    );
  }
}
