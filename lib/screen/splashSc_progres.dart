
import 'package:flutter/material.dart';
import 'package:sketch/screen/wel_come.dart';
import 'package:video_player/video_player.dart';

class splashSc_progres extends StatefulWidget {
  static const routeName = '/splash_screen2';
  const splashSc_progres({super.key});

  @override
  State<splashSc_progres> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashSc_progres> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/images/welcome_progress.mp4")
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
            _controller!.setLooping(false);
          });
    //Navigate to AppBarScreen after video is done playing
    _controller!.addListener(checkVideo);
  }

  void checkVideo() {
    if (_controller!.value.position == _controller!.value.duration) {
      Navigator.pushReplacementNamed(context, wel_come.routeName);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 14, 14),
      body: Center(
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container()),
    );
  }
}
