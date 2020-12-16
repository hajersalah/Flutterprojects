import 'package:flutter/material.dart';

class MovieInfoItem extends StatelessWidget {
  final String title;
  final dynamic data;
  MovieInfoItem(this.title, this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        Text(
          data,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
