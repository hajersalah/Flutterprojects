import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:movies_app/helpers/movies_names.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/users.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/providers/users_provider.dart';
import 'package:movies_app/screens/authentication_screen.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenre(this.genreId);
  MoviesList.trending() : this.genreId = null;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
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
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchMoviesByGenreId(widget.genreId);
      } else {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies();
      }
      setState(() {
        successful = done;
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      child: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView.builder(
                  itemExtent: 140,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  //Provider.of<MoviesProvider>(context).moviesByGenre.length,
                  itemBuilder: (context, index) {
                    Movie movie = (widget.genreId != null)
                        ? Provider.of<MoviesProvider>(context)
                            .moviesByGenre[index]
                        : Provider.of<MoviesProvider>(context)
                            .trendingMovies[index];
                    bool isFav = Provider.of<MoviesProvider>(context)
                        .isFavorite(movie.id);
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: movie);
                              //push(MaterialPageRoute(builder: (context) {return MovieDetailsScreen();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(movie.posterUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Row(children: [
                                      Text(
                                        '${movie.rating}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                        child: RatingBar(
                                          itemSize: 20,
                                          itemCount: 5,
                                          initialRating: movie.rating / 2,
                                          ignoreGestures: true,
                                          allowHalfRating: true,
                                          //itemPadding: EdgeInsets.all(2),
                                          onRatingUpdate: null,
                                          itemBuilder: (context, index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                        ),
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            //top: 5,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withOpacity(0)
                                ]),
                              ),
                              child: IconButton(
                                icon: (isFav)
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                                color: Theme.of(context).accentColor,
                                onPressed: () async {
                                  bool validToken =
                                      await Provider.of<UsersProvider>(context,
                                              listen: false)
                                          .refreshTokenIfNecessry();
                                  if (validToken) {
                                    Users user = Provider.of<UsersProvider>(
                                            context,
                                            listen: false)
                                        .currentUser;
                                    Provider.of<MoviesProvider>(context,
                                            listen: false)
                                        .toggleFavoriteStatus(movie, user);
                                  } else {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text('Error has occured.'),
                                        content: Text(
                                            'sorry ,you have to login again'),
                                        actions: [
                                          FlatButton(
                                            child: Text('ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    Navigator.of(context).pushReplacementNamed(
                                        AuthenticationScreen.routeName);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
