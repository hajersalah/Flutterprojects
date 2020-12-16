import 'package:flutter/material.dart';

class MovieOverView extends StatelessWidget {
  final String overView;
  MovieOverView(this.overView);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Over View',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            overView,
            style: TextStyle(fontSize: 15, color: Colors.white),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
