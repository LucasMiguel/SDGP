import 'package:flutter/material.dart';
import 'package:sdgp/views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
