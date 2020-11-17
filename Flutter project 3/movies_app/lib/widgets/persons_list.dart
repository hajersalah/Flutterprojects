import 'package:flutter/material.dart';
//import 'package:movies_app/helpers/movies_names.dart';
import 'package:movies_app/helpers/persons_name.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
          itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: PersonsName.persons.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              PersonsName.persons[index]['image_url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        PersonsName.persons[index]['person_name'],
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        //maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]));
          }),
    );
  }
}
