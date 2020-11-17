import 'package:flutter/material.dart';
//import 'package:get_close_to_flutter/first_screen.dart';
import 'package:get_close_to_flutter/second_screen.dart';
//import 'package:get_close_to_flutter/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondScreen(),
    );
  }
}
