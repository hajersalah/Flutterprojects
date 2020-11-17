import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movies_list.dart';

class MoviesByGenre extends StatefulWidget {
  @override
  _MoviesByGenreState createState() => _MoviesByGenreState();
}

class _MoviesByGenreState extends State<MoviesByGenre>
    with TickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(isScrollable: true, controller: controller, tabs: [
            Tab(text: 'action'),
            Tab(text: 'romance'),
            Tab(text: 'Sci-Fi'),
            Tab(text: 'horror'),
            Tab(text: 'adventure'),
            Tab(text: 'comedy'),
          ]),
        ),
        body: TabBarView(controller: controller, children: [
          MoviesList(),
          MoviesList(),
          MoviesList(),
          MoviesList(),
          MoviesList(),
          MoviesList(),
          /*Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.orange,
          ),*/
        ]),
      ),
    );
  }
}
