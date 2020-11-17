//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/constants.dart';
import 'package:movies_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies_App',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.primaryColor,
        //Theme.of(context).primaryColor,
        // This is the theme of your application.
        fontFamily: "Poppins",
        textTheme: TextTheme(
            headline6: TextStyle(
          fontSize: 15,
          color: Colors.blueGrey[600],
          fontWeight: FontWeight.bold,
        )),
        primarySwatch: Constants.primaryColor,
        accentColor: Color.fromRGBO(235, 198, 2, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
