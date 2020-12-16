import 'package:flutter/material.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/tmdb_handler.dart';

class GenresProvider with ChangeNotifier {
  List<Genre> genres;
  List<Genre> movieGenres;

  Future<bool> fetchGenres() async {
    try {
      // its very important to write async & await here !!
      genres = await TMDBHandler.instance.getGenres();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
