import 'package:flutter/material.dart';

class MovieGenreItem extends StatelessWidget {
  final String genreName;
  MovieGenreItem(this.genreName);

  //final String genreName;
  //MovieGenreItem(this.genreName);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(right: 3, left: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white)),
      child: Text(
        genreName,
        //Provider.of<MoviesProvider>(context).fetchMoviesGenre(Movie.fromJson('id')),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
