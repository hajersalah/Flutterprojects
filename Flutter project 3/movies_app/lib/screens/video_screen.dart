import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String videoKey;
  VideoScreen(this.videoKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //video player
          Center(
            child: YoutubePlayer(
                controller: YoutubePlayerController(initialVideoId: videoKey)),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }
}
