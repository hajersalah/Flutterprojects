class Movie {
  final int id;
  final String title;
  final double rating;
  final String posterUrl, backPosterUrl;

  Movie.fromJson(dynamic json)
      : this.id = json['id'],
        this.title = json['title'],
        this.rating = json['vote_average'].toDouble(),
        this.posterUrl =
            'https://image.tmdb.org/t/p/original/${json['poster_path']}',
        // from the image it self like : https://image.tmdb.org/t/p/w600_and_h900_bestv2/sovNinySiSUgv7xGr2ax803R5i8.jpg
        this.backPosterUrl =
            'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
}
