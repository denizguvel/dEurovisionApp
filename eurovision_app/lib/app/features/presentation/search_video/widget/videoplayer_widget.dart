import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A simple wrapper widget for the YouTube player.
/// Uses YouTubePlayerController with a progress indicator.
class YoutubePlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
    );
  }
}