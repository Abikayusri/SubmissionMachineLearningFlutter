import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:transcript_app/ui/transcript_page.dart';
import 'package:transcript_app/widget/audio_player_widget.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Transcript App'),
      ),
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        AudioPlayerWidget(audioPlayer: audioPlayer),
        FilledButton.icon(
          label: Text("Analyze"),
          onPressed: () {
            final navigator = Navigator.of(context);
            navigator.pushNamed(TranscriptPage.route);
          },
        ),
      ],
    );
  }
}
