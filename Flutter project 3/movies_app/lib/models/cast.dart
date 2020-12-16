class Cast {
  final int id;
  final String name;
  final String posterUrl;

  Cast.fromJson(dynamic json)
      : this.id = json['id'],
        this.name = json['name'],
        this.posterUrl =
            'https://image.tmdb.org/t/p/original/${json['profile_path']}';
  // the link it self : https://image.tmdb.org/t/p/w600_and_h900_bestv2/kpaBw1oyfu2vGS2t9gGBz1Pz7vk.jpg
}
