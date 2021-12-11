import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainStyle {
  ///Font of principal menu
  final fontMenu = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );

  ///Font of title of the screens
  final fontTitle = TextStyle(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  ///Fonts on the label of main principal price (Total Price)
  final fontLabelMainPrice = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  ///Fonts of the main principal price (Total Price)
  final fontMainPrice = TextStyle(
    color: Color.fromRGBO(71, 180, 101, 1),
    fontSize: 42,
    fontWeight: FontWeight.w600,
  );

  ///Font of the iten's names
  final fontLabelItens = TextStyle(
    color: Colors.black,
    fontSize: 9,
    fontWeight: FontWeight.w200,
  );

  ///Font of the iten's names
  final fontItenName = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  ///Font of the iten's characteristics
  final fontCharacttIten = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  ///Font of the bottom menu
  final fontBottomMenu = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
