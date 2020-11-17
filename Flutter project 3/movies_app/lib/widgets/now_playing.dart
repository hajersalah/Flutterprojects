import 'package:flutter/material.dart';
import 'package:movies_app/helpers/movies_names.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      //color: Theme.of(context).accentColor,
      child: PageIndicatorContainer(
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 5),
        padding: EdgeInsets.all(5),
        length: 5,
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    //fit: BoxFit.cover, <<<<< this is better
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        MoviesNames.nowPlaying[index]['poster_url']),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0,
                          0.5,
                        ]),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: IconButton(
                      icon: Icon(Icons.play_circle_outline),
                      color: Theme.of(context).accentColor,
                      iconSize: 50,
                      onPressed: () {}),
                ),
                Positioned(
                  bottom: 40,
                  left: 10,
                  child: Text(
                    MoviesNames.nowPlaying[index]['movie_name'],
                    overflow: TextOverflow
                        .ellipsis, // when the name is too large ...>> 3 dots will appear
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                )
              ],
            );
            /*Container(
              color: Theme.of(context).accentColor,);*/
          },
        ),
      ),
    );
  }
}
