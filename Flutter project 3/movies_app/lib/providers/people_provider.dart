import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/models/tmdb_handler.dart';

class PeopleProvider with ChangeNotifier {
  List<Person> trendingPeople;
  List<Cast> cast;

  Future<bool> fetchTrendingPeople() async {
    try {
      // its very important to write async & await here !!
      trendingPeople = await TMDBHandler.instance.getTrendingPeople();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> fetchCastbyId(int movieId) async {
    try {
      // its very important to write async & await here !!
      cast = await TMDBHandler.instance.getCast(movieId);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
