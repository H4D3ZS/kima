import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final File file;

  const VideoCard(this.file, {Key? key}) : super(key: key);

  @override
  VideoCardState createState() => VideoCardState();
}

class VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  late Widget videoStatusAnimation;

  @override
  void initState() {
    super.initState();

    videoStatusAnimation = Container();

    _controller = VideoPlayerController.file(widget.file)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then(
        (value) => VideoPlayerController.file(widget.file)
          ..initialize().then((value) {
            Timer(const Duration(milliseconds: 0), () {
              if (!mounted) return;

              setState(() {});
            });
          }),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 16 / 9,
        child: _controller.value.isInitialized ? videoPlayer() : Container(),
      );

  Widget videoPlayer() => Stack(
        children: <Widget>[
          video(),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          Center(child: videoStatusAnimation),
        ],
      );

  Widget video() => GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          if (!_controller.value.isInitialized) {
            return;
          }
          if (_controller.value.isPlaying) {
            videoStatusAnimation = const FadeAnimation(child: Icon(Icons.pause, size: 100.0, color: Colors.white));
            _controller.pause();
          } else {
            videoStatusAnimation = const FadeAnimation(child: Icon(Icons.play_arrow, size: 100.0, color: Colors.white));
            _controller.play();
          }
        },
      );
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({required this.child, this.duration = const Duration(milliseconds: 1000), Key? key})
      : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => animationController.isAnimating
      ? Opacity(
          opacity: 1.0 - animationController.value,
          child: widget.child,
        )
      : Container();
}
