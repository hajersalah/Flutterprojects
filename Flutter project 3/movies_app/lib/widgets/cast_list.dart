import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:provider/provider.dart';

class CastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
          itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<PeopleProvider>(context).trendingPeople.length,
          itemBuilder: (context, index) {
            Cast cast =
                Provider.of<PeopleProvider>(context, listen: false).cast[index];
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(cast.posterUrl),
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
                    cast.name,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    //overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
