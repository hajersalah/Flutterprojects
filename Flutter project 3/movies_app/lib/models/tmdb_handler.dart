import 'package:dio/dio.dart';
import 'package:movies_app/helpers/api_keys.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/person.dart';

class TMDBHandler {
  TMDBHandler._private();
  static TMDBHandler _instance = TMDBHandler._private();

  static TMDBHandler get instance => _instance;
  String mainURL = 'https://api.themoviedb.org/3';
  Dio _dio = Dio();
  // API key is  in seperated file to not be used by others !!
  //get now playing movies :

  Future<List<Movie>> getNowPlaying() async {
    // from the line of 'string' to the line of 'to list' ..
    // we'll copy it every time but wigh change in the end point of the url !!!
    String url = '$mainURL/movie/now_playing';
    Map<String, String> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

// get genres :
  Future<List<Genre>> getGenres() async {
    String url = '$mainURL/genre/movie/list';
    Map<String, String> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['genres'] as List).map((genre) {
      return Genre.fromJson(genre);
    }).toList();
  }

// get movies by genre id :
  Future<List<Movie>> getMoviesByGenreId(int genreId) async {
    String url = '$mainURL/discover/movie';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
      'with_genres': genreId,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

// get trending people this week :
  Future<List<Person>> getTrendingPeople() async {
    String url = '$mainURL/trending/person/week';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['results'] as List).map((person) {
      return Person.fromJson(person);
    }).toList();
  }

// get trending movies this week :
  Future<List<Movie>> getTrendingMovies() async {
    String url = '$mainURL/trending/movie/week';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

// get movie details :
  Future<MovieDetails> getMovieDetailsById(int movieId) async {
    String url = '$mainURL/movie/$movieId';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return MovieDetails.fromJson(response.data);
  }

//get genre names :
  /*Future<List<Genre>> getGenreNames() async {
    String url = '$mainURL/genre/movie/list';
    //String url = '$mainURL/movie/{movie_id}';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
      //'movie_id': Movie.fromJson(movieId),
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['genres'] as List).map((genre) {
      return Genre.fromJson(genre);
    }).toList();
  }*/

// get Cast :
  Future<List<Cast>> getCast(int movieId) async {
    String url = '$mainURL/movie/$movieId/credits';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return (response.data['cast'] as List).map((cast) {
      return Cast.fromJson(cast);
    }).toList();
  }

  // get video(trailer):
  Future<String> getVideioKeyById(int movieId) async {
    String url = '$mainURL/movie/$movieId/videos';
    Map<String, String> params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return response.data['results'][0]['key'];
  }
}
