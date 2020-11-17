import 'package:flutter/material.dart';
import 'package:movies_app/widgets/persons_list.dart';

class TrendingPersons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TRENDING Persons OF THIS WEEK',
              style: Theme.of(context).textTheme.headline6,
            ),
            PersonsList(),
          ],
        ));
  }
}
