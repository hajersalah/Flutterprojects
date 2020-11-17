import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movies_by_genre.dart';
import 'package:movies_app/widgets/now_playing.dart';
import 'package:movies_app/widgets/trending_movies.dart';
import 'package:movies_app/widgets/trending_persons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed: () {}),
        title: Text("Movies App"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          MoviesByGenre(),
          TrendingPersons(),
          TrendingMovies(),
        ],
      ),
    );
  }
}
