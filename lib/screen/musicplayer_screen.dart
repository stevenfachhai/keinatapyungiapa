import 'package:flutter/material.dart';
import 'package:keinatapyungiapa/screen/title_screen.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final bool _isSubscribed = false;
  List<Song> _songs = [];

  @override
  void initState() {
    super.initState();
    // Check user's subscription status upon login
    // Set _isSubscribed accordingly.
  }

  void _handleDownloadSong(Song song) {
    if (_isSubscribed) {
      // Use the 'dio' package to download the song and save it locally
      // using the 'path_provider' package.
    } else {
      // Show subscription prompt or navigate to the subscription page.
    }
  }

  void _handlePlayOnlineSong(Song song) {
    // Implement logic to play the song using an online music player (e.g., audioplayers).
  }

  void _handlePlayDownloadedSong(Song song) {
    // Implement logic to play the downloaded song locally.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/image/fc.png', // Replace 'assets/background_image.jpg' with your actual image path.
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (context, index) {
              Song song = _songs[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artist),
                onTap: () {
                  if (_isSubscribed) {
                    _handlePlayOnlineSong(song);
                  } else {
                    _handlePlayDownloadedSong(song);
                  }
                },
                trailing: _isSubscribed
                    ? IconButton(
                        icon: Icon(Icons.cloud_download),
                        onPressed: () => _handleDownloadSong(song),
                      )
                    : Container(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TitleScreen()),
            );
            // Implement logic for the "Next" button.
          },
          child: Text(
            "Next",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String audioUrl;

  Song({
    required this.title,
    required this.artist,
    required this.audioUrl,
  });
}
