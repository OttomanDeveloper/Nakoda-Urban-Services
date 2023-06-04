import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashVideoPlayer extends StatefulWidget {
  final VoidCallback onEnd;
  const SplashVideoPlayer({super.key, required this.onEnd});

  @override
  State<SplashVideoPlayer> createState() => _SplashVideoPlayerState();
}

class _SplashVideoPlayerState extends State<SplashVideoPlayer> {
  /// Create an Instance of `VideoPlayerController`
  late final VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      "assets/splash.mp4",
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: false,
        allowBackgroundPlayback: false,
      ),
    );
    _controller
      ..setLooping(false)
      ..setVolume(0.0)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      })
      ..play()
      ..addListener(_videoListener);
    super.initState();
  }

  /// Listen to Changes of `VideoPlayerController`
  void _videoListener() {
    if (_controller.value.isInitialized && mounted) {
      if (_controller.value.position >= _controller.value.duration) {
        return widget.onEnd();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : const SizedBox.shrink(),
    );
  }
}
