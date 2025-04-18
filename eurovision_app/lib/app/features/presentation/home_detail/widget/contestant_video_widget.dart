import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContestantVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ContestantVideoPlayer({super.key, required this.videoUrl});

  @override
  State<ContestantVideoPlayer> createState() => _ContestantVideoPlayerState();
}

class _ContestantVideoPlayerState extends State<ContestantVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: player,
              ),
            ),
        );
      },
    );
  }
}