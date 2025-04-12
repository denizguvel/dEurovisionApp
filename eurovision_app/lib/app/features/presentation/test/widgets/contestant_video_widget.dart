import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContestantVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ContestantVideoPlayer({super.key, required this.videoUrl});

  @override
  State<ContestantVideoPlayer> createState() => _ContestantVideoPlayerState();
}

class _ContestantVideoPlayerState extends State<ContestantVideoPlayer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    String html = '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body, html {
            margin: 0;
            padding: 0;
            background-color: black;
            height: 100%;
          }
          iframe {
            width: 100%;
            height: 100%;
            border: none;
          }
        </style>
      </head>
      <body>
        <iframe 
          src="${widget.videoUrl}" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
        </iframe>
      </body>
    </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: WebViewWidget(controller: _controller),
    );
  }
}
