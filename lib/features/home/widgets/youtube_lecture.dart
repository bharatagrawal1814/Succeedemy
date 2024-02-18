import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeLecture extends StatefulWidget {
  const YoutubeLecture({super.key});

  @override
  State<YoutubeLecture> createState() => _YoutubeLectureState();
}

class _YoutubeLectureState extends State<YoutubeLecture> {
  // List<YoutubeModel> videoList = [];
  final YoutubePlayerController _ytbPlayerController =
      YoutubePlayerController.fromVideoId(
    videoId: 'Wp-e13ZCoDI',
    autoPlay: false,
    params: const YoutubePlayerParams(
      showFullscreenButton: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     _ytbPlayerController = YoutubePlayerController.fromVideoId(
    //       videoId: 'Wp-e13ZCoDI',
    //       autoPlay: true,
    //       params: const YoutubePlayerParams(
    //         showFullscreenButton: true,
    //       ),
    //     );
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(
          controller: _ytbPlayerController,
        ));
  }
}
