import 'package:delivery_manager/screens/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode theme;
  @override
  void initState() {
    super.initState();
    theme = ThemeMode.light;
  }

  void toggleTheme() {
    setState(() {
      if (theme == ThemeMode.light)
        theme = ThemeMode.dark;
      else
        theme = ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Map<String , List<int>> mp = Map<String , List<int>>(); // original map with out sorting
    //SplayTreeMap<String, List<int>> mp = SplayTreeMap<String,List<int>>();
    // the diffrence is that it sorts the data inside it
    /*
    //today:
    mp[DateFormat("d-M-y").format(DateTime.now())] = [];
    mp[DateFormat("d-M-y").format(DateTime.now())].add(1);
    mp[DateFormat("d-M-y").format(DateTime.now())].add(2);
    //yesterday:
    mp[DateFormat("d-M-y").format(DateTime.now().subtract(Duration(days: 1)))] =
        [];
    mp[DateFormat("d-M-y").format(DateTime.now().subtract(Duration(days: 1)))]
        .add(4);
    mp[DateFormat("d-M-y").format(DateTime.now().subtract(Duration(days: 1)))]
        .add(5);
    //before yesterday
    mp[DateFormat("d-M-y").format(DateTime.now().subtract(Duration(days: 2)))] =
        [];
    mp[DateFormat("d-M-y").format(DateTime.now().subtract(Duration(days: 2)))]
        .add(3);

    print(mp);
    print(mp[DateFormat("d-M-y").format(DateTime.now())]);
    print(mp[DateFormat("d-M-y")
        .format(DateTime.now().subtract(Duration(days: 1)))]);
    print(mp[DateFormat("d-M-y")
        .format(DateTime.now().subtract(Duration(days: 2)))]);*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Manager', // shows in android only .. not IOS ##
      theme: ThemeData(
        //primarySwatch: Colors.blue , // it takes all shades of blue
        primaryColor: Colors
            .blue[900], // it takes just the shade of the color you've added !!
        accentColor: Colors
            .white, // we used it to any thing isn't primary/important in our app !!
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        //primarySwatch: Colors.blue , // it takes all shades of blue
        primaryColor: Colors
            .grey[900], // it takes just the shade of the color you've added !!
        accentColor: Colors.grey[
            800], // we used it to any thing isn't primary/important in our app !!
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: theme,
      home: HomeScreen(toggleTheme),
    );
  }
}
