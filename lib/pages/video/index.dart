import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

class BasicExamplePage extends StatefulWidget {
  const BasicExamplePage({Key? key}) : super(key: key);

  @override
  State<BasicExamplePage> createState() => _BasicExamplePageState();
}

class _BasicExamplePageState extends State<BasicExamplePage> {
  final MeeduPlayerController _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.primary,
    enabledButtons: const EnabledButtons(pip: true),
    // enabledControls: const EnabledControls(doubleTapToSeek: false),
    pipEnabled: true,
  );
  final TextEditingController _urlController = TextEditingController(text: "https://movietrailers.apple.com/movies/paramount/the-spongebob-movie-sponge-on-the-run/the-spongebob-movie-sponge-on-the-run-big-game_h720p.mov");
  bool _downloading = false;
  StreamSubscription? _playerEventSubs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    _playerEventSubs?.cancel();
    _meeduPlayerController.dispose();
    super.dispose();
  }

  _init() async {
    String url = _urlController.text.trim();
    await _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        source: url,
      ),
      autoplay: true,
      looping: false,
    );
  }

  Future<void> _downloadVideo() async {
    String url = _urlController.text.trim();

    if (url.isEmpty) {
      return;
    }

    setState(() {
      _downloading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: MeeduVideoPlayer(
                  controller: _meeduPlayerController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Video URL',
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _init();
                },
                child: const Text('play'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _downloading ? null : _downloadVideo,
                child: _downloading
                    ? const CircularProgressIndicator()
                    : const Text('Download'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
