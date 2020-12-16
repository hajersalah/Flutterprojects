import 'package:flutter/material.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/widgets/movie_genre_item.dart';

class MovieGenres extends StatelessWidget {
  final List<Genre> genres;
  MovieGenres(this.genres);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Genres',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 15, fontWeight: FontWeight.normal)),
        Wrap(
          children: genres.map((genre) {
            return MovieGenreItem(genre.name);
          }).toList(),
        ),
      ]),
    );
  }
}
