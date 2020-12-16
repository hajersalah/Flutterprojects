import 'package:flutter/material.dart';
import 'package:movies_app/models/users.dart';
import 'package:movies_app/providers/genres_provider.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:movies_app/providers/users_provider.dart';
import 'package:movies_app/widgets/movies_by_genre.dart';
import 'package:movies_app/widgets/my_drawer.dart';
import 'package:movies_app/widgets/now_playing.dart';
import 'package:movies_app/widgets/trending_movies.dart';
import 'package:movies_app/widgets/trending_people.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstRun, successful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool validToken = await Provider.of<UsersProvider>(context, listen: false)
          .refreshTokenIfNecessry();
      Users user =
          Provider.of<UsersProvider>(context, listen: false).currentUser;
      // now i can ask for data .. " call Provider !"
      List<bool> results = await Future.wait([
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchFavorites(user),
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchNowPlayingMovies(),
        Provider.of<GenresProvider>(context, listen: false).fetchGenres(),
        Provider.of<PeopleProvider>(context, listen: false)
            .fetchTrendingPeople(),
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies()
      ]);
      setState(() {
        successful =
            (!results.any((element) => element == false) && validToken);
        firstRun = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        // we don't nead this dehaze .. we can the drawer instead >>
        /*leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
            }),*/
        title: Text("Movies App"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView(
                  children: [
                    NowPlaying(),
                    MoviesByGenre(),
                    TrendingPeople(),
                    TrendingMovies(),
                  ],
                )
              : Center(
                  child: Text(
                    'Error has occured',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
