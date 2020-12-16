import 'package:flutter/material.dart';
import 'package:movies_app/helpers/constants.dart';
import 'package:movies_app/providers/genres_provider.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/providers/people_provider.dart';
import 'package:movies_app/providers/users_provider.dart';
import 'package:movies_app/screens/authentication_screen.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MoviesProvider()),
    ChangeNotifierProvider(create: (context) => GenresProvider()),
    ChangeNotifierProvider(create: (context) => PeopleProvider()),
    ChangeNotifierProvider(create: (context) => UsersProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies_App',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.primaryColor,
        //Theme.of(context).primaryColor,
        // This is the theme of your application.
        fontFamily: "Poppins",
        textTheme: TextTheme(
            headline6: TextStyle(
          fontSize: 15,
          color: Colors.blueGrey[600],
          fontWeight: FontWeight.bold,
        )),
        primarySwatch: Constants.primaryColor,
        accentColor: Color.fromRGBO(235, 198, 2, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future:
              Provider.of<UsersProvider>(context, listen: false).isLoggedIn(),
          builder: (context, snapshot) {
            // future loading:
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else // true >> return home screen
            if (snapshot.data == true) {
              return HomeScreen();
            } else // false >> return auth screen
            {
              return AuthenticationScreen();
            }
          }),
      routes: {
        // route name as string'' : (context) => screen elly elmfrod yro7laha
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
      },
    );
  }
}
