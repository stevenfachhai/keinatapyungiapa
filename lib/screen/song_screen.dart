import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

const audio = {
  1: 'assets/audio/ko.mp3',
  2: 'assets/audio/Marareih.mp3',
};

const song = {
  1: 'lalpaatha',
  2: 'engtia',
};

const lalpaatha = '''

''';

const engtia = '''

''';

enum PlayerState {
  PLAYING,
  STOPPED,
  COMPLETED,
  PAUSED,
}

class SongScreen extends StatefulWidget {
  const SongScreen({
    Key? key,
    required this.titleNumber,
  }) : super(key: key);

  final int titleNumber;

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  String audioDuration = '0:00';
  double sliderValue = 0.0;
  Duration totalDuration = Duration(seconds: 0);
  late Timer timer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration ?? Duration(seconds: 0);
        final minutes = (totalDuration.inSeconds ~/ 60).toString();
        final seconds =
            (totalDuration.inSeconds % 60).toString().padLeft(2, '0');
        audioDuration = '$minutes:$seconds';
      });
    });
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.PLAYING) {
        timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
          audioPlayer.getCurrentPosition().then((position) {
            setState(() {
              sliderValue = (position?.inMilliseconds ?? 0).toDouble() /
                  (totalDuration.inMilliseconds > 0
                      ? totalDuration.inMilliseconds
                      : 1);
            });
          });
        });
      } else if (state == PlayerState.STOPPED ||
          state == PlayerState.COMPLETED ||
          state == PlayerState.PAUSED) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    timer.cancel();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void playNext() {
    // Implement logic to play the next song
    // For example, you can increment the `titleNumber` and play the corresponding song.
  }

  void playPrevious() {
    // Implement logic to play the previous song
    // For example, you can decrement the `titleNumber` and play the corresponding song.
  }

  void onSliderChanged(double value) {
    final Duration newPosition =
        Duration(milliseconds: (totalDuration.inMilliseconds * value).round());
    audioPlayer.seek(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    final music = audio[widget.titleNumber] ?? '';
    final songTitle = song[widget.titleNumber] ?? '';
    final songLyrics = songTitle == 'lalpaatha' ? lalpaatha : engtia;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Song title at the top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              songTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Image in the middle
          Expanded(
            child: Image.asset(
              'assets/image/fc.png',
              fit: BoxFit.contain,
            ),
          ),
          // Slider and Controls at the bottom
          Column(
            children: [
              Slider(
                value: sliderValue,
                onChanged: onSliderChanged,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: playPrevious,
                    icon: Icon(Icons.skip_previous),
                  ),
                  ElevatedButton(
                    onPressed: playPause,
                    child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: playNext,
                    icon: Icon(Icons.skip_next),
                  ),
                  SizedBox(width: 16),
                  Text(
                    audioDuration,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              // Display the song lyrics below the controls
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  songLyrics,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
