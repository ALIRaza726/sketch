import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:video_player/video_player.dart';

class scrol_video extends StatefulWidget {
  static const routeName = '/scrolSc';
  const scrol_video({super.key});

  @override
  State<scrol_video> createState() => _scrolScState();
}

class _scrolScState extends State<scrol_video> {
  static const _videoList = [
    {"assets": "welcome_progress.mp4"},
    {"assets": "welcome_progress.mp4"},
    {"assetss": "welcome_progress.mp4"},
    {"assets": "welcome_progress.mp4"}
  ];
  int _currentPage = 0;
  late List<VideoPlayerController> _controllers;
  late PageController _pageController;

  // Widget _buitlerScrollView(int index) {
  //   //var item = _videolist[index];
  //   // super.initState();
  //   _controller = VideoPlayerController.asset("assets/${_videoList[index]}")
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _controller!.play();
  //       _controller!.setLooping(false);
  //     });

  //   return Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 40),
  //       child: _controller!.value.isInitialized
  //           ? AspectRatio(
  //               aspectRatio: _controller!.value.aspectRatio,
  //               child: VideoPlayer(_controller!),
  //             )
  //           : Container());
  // }
  //late PageController pageController = PageController();

  late PageController pageController1 = PageController();
  int pageNo = 0;
  int pageNo1 = 0;

  Timer? _timer;

  @override
  void initState() {
    // pageController = PageController();
    pageController1 = PageController();
    super.initState();
    _controllers = _videoList
        .map(
            (video) => VideoPlayerController.asset('assets/images/welcome.mp4'))
        .toList();
    _initializeVideoPlayers();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), _timerCallback);

    // code for the image automated
    //code for the generating list

    // initialize the timer to change pages after every few milisecondes
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (pageNo1 < 5) {
        pageNo1++;
      } else {
        pageNo1 = 0;
      }
      pageController1.animateToPage(pageNo1,
          duration: const Duration(seconds: 2), curve: Curves.elasticOut);
    });
  }

  void _initializeVideoPlayers() async {
    for (var controller in _controllers) {
      await controller.initialize();
      controller.setLooping(false);
      controller.addListener(() {
        if (!controller.value.isPlaying &&
            controller.value.position == controller.value.duration) {
          _onVideoEnd();
        }
      });
    }
    setState(() {});
  }

  void _timerCallback(Timer timer) {
    if (_currentPage < _controllers.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
    );
  }

  void _onVideoEnd() {
    if (_currentPage < _controllers.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.jumpToPage(_currentPage);
    _controllers[_currentPage].play();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();

    pageController1.dispose();
    super.dispose();
    _pageController.dispose();
    // // TODO: implement dispose
    super.dispose();
    // _controller!.dispose();
  }

  Widget _buildVideoPlayer(int index) {
    var controller = _controllers[index];
    return controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _controllers.length,
        (index) => GestureDetector(
          onTap: () {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
            setState(() {
              _currentPage = index;
              _controllers[index].play();
            });
          },
          child: Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 245, 245),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'What\'s New',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemCount: _controllers.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _controllers[index].play();
                });
              },
              itemBuilder: (context, index) => _buildVideoPlayer(index),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          _buildIndicator(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     4,
          //     (index) => InkWell(
          //       onTap: () {
          //         _pageController.animateToPage(index,
          //             duration: const Duration(milliseconds: 1000),
          //             curve: Curves.decelerate);
          //       },
          //       child: Container(
          //         margin: const EdgeInsets.all(2.0),
          //         child: Icon(
          //           Icons.circle,
          //           size: Responsive.isMobile(context) ? 3 : 15,
          //           color: pageNo == index
          //               ? Colors.indigoAccent
          //               : Colors.grey.shade300,
          //         ),
          //       ),
          //     ),
          //   ).toList(),
          // ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'What\'s New',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemCount: 6,
              controller: pageController1,
              onPageChanged: (index) {
                pageNo1 = index;
                setState(() {});
              },
              itemBuilder: (context, index) => AnimatedBuilder(
                animation: pageController1,
                builder: (ctx, child) {
                  return child!;
                },
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 40),
                  // child: _controller!.value.isInitialized
                  //     ? AspectRatio(
                  //         aspectRatio: _controller!.value.aspectRatio,
                  //         child: VideoPlayer(_controller!),
                  //       )
                  //     : Container(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/background1.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (index) => InkWell(
                onTap: () {
                  pageController1.animateToPage(index,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.decelerate);
                },
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.circle,
                    size: Responsive.isMobile(context) ? 3 : 15,
                    color: pageNo1 == index
                        ? Colors.indigoAccent
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
