import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IosVideoPlayerPage extends StatefulWidget {
  const IosVideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<IosVideoPlayerPage> createState() => _IosVideoPlayerPageState();
}

class _IosVideoPlayerPageState extends State<IosVideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('http://localhost:8080/hls/test.m3u8'),
    );

    try {
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライブ配信'),
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
