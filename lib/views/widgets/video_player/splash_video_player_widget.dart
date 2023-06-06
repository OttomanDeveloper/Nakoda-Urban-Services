import 'dart:developer';

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
  late final VideoPlayerController _con;

  @override
  void initState() {
    _con = VideoPlayerController.asset(
      "assets/splash.mp4",
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: false,
        allowBackgroundPlayback: false,
      ),
    );
    _con
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

  /// Hold status of Video Finisheda
  bool _isVideoFinished = false;

  /// Listen to Changes of `VideoPlayerController`
  void _videoListener() {
    if (_con.value.isInitialized && mounted && !_isVideoFinished) {
      if (_con.value.position >= _con.value.duration) {
        log("Video Finished");
        // Mark video Finished to true
        _isVideoFinished = true;
        return widget.onEnd();
      }
    }
  }

  @override
  void dispose() {
    _con.removeListener(_videoListener);
    _con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _con.value.isInitialized
          ? VideoPlayer(_con)
          : const SizedBox.shrink(),
    );
  }
}
