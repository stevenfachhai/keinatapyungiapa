import 'package:flutter/material.dart';
import 'package:keinatapyungiapa/screen/song_screen.dart';
import '../music/song_title.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  _TitleScreenState createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  List<String> filteredSongTitle = songTitle;
  bool showLabel = true;

  void filterTitles(String searchText) {
    setState(() {
      showLabel = searchText.isEmpty;
      filteredSongTitle = songTitle
          .where(
              (title) => title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var searchController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Zawn Awlna'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterTitles,
              decoration: InputDecoration(
                hintText: 'Number emaw Hla thu zawnna',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSongTitle.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      filteredSongTitle[index],
                      style: const TextStyle(fontSize: 17),
                    ),
                    onTap: () {
                      int titleIndex =
                          songTitle.indexOf(filteredSongTitle[index]);
                      print(titleIndex + 1); // Print index for ChapterScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongScreen(
                            titleNumber: titleIndex + 1,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
