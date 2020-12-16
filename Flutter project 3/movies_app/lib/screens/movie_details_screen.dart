import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:movies_app/screens/video_screen.dart';
import 'package:movies_app/widgets/movie_cast.dart';
import 'package:movies_app/widgets/movie_genres.dart';
import 'package:movies_app/widgets/movie_info.dart';
import 'package:movies_app/widgets/movie_overview.dart';
import 'package:movies_app/widgets/movie_rating.dart';
import 'package:provider/provider.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool firstRun, successful;
  MovieDetails movieDetails;
  Movie movie;
  String videoKey;
  List<Cast> cast;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments as Movie;
      List results = await Future.wait([
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchMovieDetailsById(movie.id),
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchVideoKeyById(movie.id),
        Provider.of<PeopleProvider>(context, listen: false)
            .fetchCastbyId(movie.id),
      ]);
      setState(() {
        firstRun = false;
        if (results.any((element) => element == null)) {
          successful = false;
        } else {
          successful = true;
          movieDetails = results[0];
          videoKey = results[1];
          //cast = results[2];
        }
        //!results.any((element) => element == false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context).settings.arguments as Movie;
    return Scaffold(
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? SliverFab(
                  floatingWidget: FloatingActionButton(
                      child: Icon(Icons.play_arrow),
                      backgroundColor: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return VideoScreen(videoKey);
                          }),
                        );
                      }),
                  expandedHeight: MediaQuery.of(context).size.height * 0.35,
                  slivers: [
                      SliverAppBar(
                        pinned: true,
                        //backgroundColor: Colors.blue,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.35,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Container(
                            margin: EdgeInsets.only(right: 75),
                            child: Text(
                              movie.title,
                              style: TextStyle(fontSize: 15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          background: Stack(children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.network(
                                movie.backPosterUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0, 0.8]),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(15),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            MovieRating(movie.rating),
                            MovieOverView(movieDetails.overView),
                            MovieInfo(
                                (movieDetails.budget).toString(),
                                (movieDetails.duration).toString(),
                                movieDetails.releasedDate),
                            MovieGenres(movieDetails.genres),
                            //MovieCast(),
                          ]),
                        ),
                      ),
                    ])
              : Center(
                  child: Text(
                    'Error has occured',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
