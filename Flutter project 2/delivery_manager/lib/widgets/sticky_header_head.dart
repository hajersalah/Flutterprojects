import 'package:flutter/material.dart';

class StickyHeaderHead extends StatelessWidget {
  final String date;
  StickyHeaderHead(this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          // an other shape : borderRadius: BorderRadius.circular(10) >> its all rounded
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      elevation: 10,
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04)
          .add(EdgeInsets.only(bottom: 8)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Text(
          date,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
