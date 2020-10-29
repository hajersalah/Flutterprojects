import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // two ways to make margins:
      // 1...
      margin: EdgeInsets.all(30), // all will change all directions
      //margin: EdgeInsets.symmetric(horizontal: 30), // semetric will change 2 direction in one time with the same num!
      //margin: EdgeInsets.only(top : 30), // only will change only the direction you choose
      // 2...
      //height: MediaQuery.of(context).size.height * 0.15,
      //alignment: Alignment.center,
      //color: Colors.amber, // when you need to know the size of your cont. color it !! ^^
      child: Text(
        "Delivery Manager",
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
