import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> quotes = [
    'It may not be a good day , but there is something good in every day',
    'I have loved the stars too findly to be fearful of the night',
    "Don't believe every thing you think",
    "Worrying about things might go wrong doesn't help things to go right",
    'The way to get started is to quit talking and begin doing',
    'Every one needs a little inspiration from time to time',
    'Those who dare to fail miserably can achieve greatly',
    'One day you will be proud you made it through this',
  ];
  List<Image> images = [
    Image.asset('assets/images/4314-1.jpg'),
    Image.asset('assets/images/4314-2.jpg'),
    Image.asset('assets/images/4314-7.jpg'),
    Image.asset('assets/images/4314-8.jpg'),
    Image.asset('assets/images/4314-9.jpg'),
    Image.asset('assets/images/4314.jpg'),
    Image.asset('assets/images/Desert.jpg'),
    Image.asset('assets/images/Hydrangeas.jpg'),
  ];
  int quotesIndex = 0, imagesIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          padding: EdgeInsets.all(5),
          child: Text(
            "pre.",
            style: TextStyle(
                color: Colors.white,
                //fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              quotesIndex--;
              imagesIndex--;
            });
            print("prev.");
          },
        ),
        title: Text("Photos Gallery"),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        actions: [
          FlatButton(
            child: Text(
              "next",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                quotesIndex++;
                imagesIndex++;
              });
              print("next");
            },
          ),
        ],
      ),
      body: Center(
        child: (quotesIndex < 8 && imagesIndex < 8)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        quotes[quotesIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Center(
                    child: images[imagesIndex],
                  )
                ],
              )
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" finished "),
                      RaisedButton(
                        child: Text("start again"),
                        onPressed: () {
                          setState(() {
                            quotesIndex = 0;
                            imagesIndex = 0;
                          });
                        },
                      ),
                    ]),
              ),
      ),
    );
  }
}
