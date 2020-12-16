import 'package:flutter/material.dart';
import 'package:movies_app/providers/genres_provider.dart';
import 'package:movies_app/widgets/movies_list.dart';
import 'package:provider/provider.dart';

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
    controller = TabController(
        length:
            Provider.of<GenresProvider>(context, listen: false).genres.length,
        vsync: this);
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
          bottom: TabBar(
            isScrollable: true,
            controller: controller,
            tabs: Provider.of<GenresProvider>(context).genres.map((genre) {
              return Tab(
                text: genre.name,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: Provider.of<GenresProvider>(context).genres.map((genre) {
            return MoviesList.byGenre(genre.id);
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
          }).toList(),
        ),
      ),
    );
  }
}
