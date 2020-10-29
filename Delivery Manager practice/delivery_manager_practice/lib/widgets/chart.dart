import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Text(
            "No Orders Yet !!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            //textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
