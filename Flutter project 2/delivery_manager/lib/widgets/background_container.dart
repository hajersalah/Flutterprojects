import 'package:flutter/material.dart';

class BackGroundContainer extends StatelessWidget {
  final bool portrait;
  BackGroundContainer(this.portrait);
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * ((portrait == true) ? 0.3 : 0.4),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
    );
  }
}
