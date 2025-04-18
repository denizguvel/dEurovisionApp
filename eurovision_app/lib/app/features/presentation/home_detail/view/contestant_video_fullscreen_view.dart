import 'package:eurovision_app/app/features/presentation/home_detail/view/home_detail_imports.dart';
import 'package:flutter/services.dart';

class ContestantVideoFullScreenView extends StatefulWidget {
  final String videoUrl;

  const ContestantVideoFullScreenView({super.key, required this.videoUrl});

  @override
  State<ContestantVideoFullScreenView> createState() => _ContestantVideoFullScreenViewState();
}

class _ContestantVideoFullScreenViewState extends State<ContestantVideoFullScreenView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        isLive: false,
        forceHD: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          debugPrint("Player is ready.");
        },
        onEnded: (meta) {
          Navigator.pop(context);
        },
        
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text("Video"),
          ),
          body: Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: player,
              ),
            ),
          ),
        );
      },
    );
  }
}