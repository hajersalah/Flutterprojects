import 'package:flutter/material.dart';

class Constants {
  static Map<int, Color> _colorMap = {
    50: Color.fromRGBO(0, 43, 54, 0.1),
    100: Color.fromRGBO(0, 43, 54, 0.2),
    200: Color.fromRGBO(0, 43, 54, 0.3),
    300: Color.fromRGBO(0, 43, 54, 0.4),
    400: Color.fromRGBO(0, 43, 54, 0.5),
    500: Color.fromRGBO(0, 43, 54, 0.6),
    600: Color.fromRGBO(0, 43, 54, 0.7),
    700: Color.fromRGBO(0, 43, 54, 0.8),
    800: Color.fromRGBO(0, 43, 54, 09),
    900: Color.fromRGBO(0, 43, 54, 1),
  };
  static MaterialColor primaryColor = MaterialColor(0xFF002B36, _colorMap);
}
