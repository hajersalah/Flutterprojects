import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRating extends StatelessWidget {
  final double rating;
  MovieRating(this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$rating',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        FittedBox(
          child: RatingBar(
            itemSize: 20,
            itemCount: 5,
            initialRating: rating / 2,
            ignoreGestures: true,
            allowHalfRating: true,
            //itemPadding: EdgeInsets.all(3),
            onRatingUpdate: null,
            itemBuilder: (context, index) {
              return Icon(
                Icons.star,
                color: Colors.amber,
              );
            },
          ),
        ),
      ],
    );
  }
}
