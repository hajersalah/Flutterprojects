import 'package:flutter/material.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:movies_app/widgets/cast_list.dart';
import 'package:provider/provider.dart';

class MovieCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Cast',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        /*Provider.of<PeopleProvider>(context).cast.map((cast) {
          return CastList();*/
        CastList()
        //}).toList(),
      ]),
    );
  }
}
