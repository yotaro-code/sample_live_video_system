import 'package:flutter/material.dart';
import 'dart:js' as js;

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  void initState() {
    super.initState();
    // プレーヤーを表示して再生開始
    js.context.callMethod('eval', [
      'if (window.videoPlayerInterface) { '
          'window.videoPlayerInterface.showPlayer(); '
          '}'
    ]);
  }

  @override
  void dispose() {
    // プレーヤーを非表示
    js.context.callMethod('eval', [
      'if (window.videoPlayerInterface) { '
          'window.videoPlayerInterface.hidePlayer(); '
          '}'
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライブ配信視聴'),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'ビデオプレーヤーはオーバーレイとして表示されます',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
