import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/helpers/movies_names.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      child: ListView.builder(
        itemExtent: 150,
        scrollDirection: Axis.horizontal,
        itemCount: MoviesNames.nowPlaying.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            MoviesNames.nowPlaying[index]['poster_url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      MoviesNames.nowPlaying[index]['movie_name'],
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: Row(children: [
                      Text(
                        "8.0",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        child: RatingBar(
                          itemSize: 25,
                          itemCount: 5,
                          initialRating: 4,
                          ignoreGestures: true,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.all(5),
                          onRatingUpdate: null,
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
