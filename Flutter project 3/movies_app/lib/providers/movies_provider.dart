import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/firebase_handler.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/tmdb_handler.dart';
import 'package:movies_app/models/users.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlaying;
  List<Movie> moviesByGenre;
  List<Movie> trendingMovies;
  List<Movie> favorites = [];
  // List<Movie> movieGenres;

  Future<bool> fetchNowPlayingMovies() async {
    try {
      // its very important to write async & await here !!
      nowPlaying = await TMDBHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> fetchMoviesByGenreId(int genreId) async {
    try {
      // its very important to write async & await here !!
      moviesByGenre = await TMDBHandler.instance.getMoviesByGenreId(genreId);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      // its very important to write async & await here !!
      trendingMovies = await TMDBHandler.instance.getTrendingMovies();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<MovieDetails> fetchMovieDetailsById(int movieId) async {
    try {
      // its very important to write async & await here !!
      return await TMDBHandler.instance.getMovieDetailsById(movieId);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<String> fetchVideoKeyById(int movieId) async {
    try {
      return await TMDBHandler.instance.getVideioKeyById(movieId);
    } catch (error) {
      return null;
    }
  }

  void toggleFavoriteStatus(Movie movie, Users user) async {
    try {
      if (isFavorite(movie.id)) {
        // we hane to ways to remove movie from favorites !!
        // 1- by (remove) :: we sent the object && she try to find this object and remove it ..
        //favorites.remove(movie); >>> // and here we need to give it the method to compare the movie with the others movie .. so this is difficult!!
        // 2- by (removewhere) :: this one is the easiest >>>
        await FireBaseHandler.instance.removeFavorite(movie, user);
        favorites.removeWhere((element) => element.id == movie.id);
      } else {
        await FireBaseHandler.instance.addFavorite(movie, user);
        favorites.add(movie);
      }
      notifyListeners();
    } catch (e) {
      print(e.response.data);
    }
  }

  bool isFavorite(int movieId) {
    return favorites.any((element) => element.id == movieId);
  }

  Future<bool> fetchFavorites(Users user) async {
    try {
      favorites = await FireBaseHandler.instance.getFavorites(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
