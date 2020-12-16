import 'package:flutter/material.dart';
//import 'package:movies_app/helpers/movies_names.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:provider/provider.dart';

class PeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
          itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          //Provider.of<PeopleProvider>(context).trendingPeople.length,
          itemBuilder: (context, index) {
            Person person =
                Provider.of<PeopleProvider>(context).trendingPeople[index];
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(person.posterUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      person.name,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]));
          }),
    );
  }
}
