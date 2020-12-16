import 'package:movies_app/models/genre.dart';

class MovieDetails {
  final String overView;
  final int budget;
  final int duration;
  final String releasedDate;
  final List<Genre> genres;

  MovieDetails.fromJson(dynamic json)
      : this.overView = json['overview'],
        this.budget = json['budget'],
        this.duration = json['runtime'],
        this.releasedDate = json['release_date'],
        this.genres = (json['genres'] as List).map((genre) {
          return Genre.fromJson(genre);
        }).toList();
}
