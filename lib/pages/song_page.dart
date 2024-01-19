// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player_app/pages/back_page.dart';
import 'package:music_player_app/provider/playlist_provider.dart';
import 'package:music_player_app/widgets/stylish_container.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  bool isShuffle = false;
  bool isRepeat = false;
  bool isFav = false;
  late PlaylistProvider _playlistProvider;
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: PlaylistProvider.instance,
        child: Builder(builder: (context) {
          _playlistProvider = Provider.of<PlaylistProvider>(context);
          var index = _playlistProvider.currentSongIndex;
          var sliderValue =
              _playlistProvider.currentDuration.inSeconds.toDouble();
          var isPlaying = _playlistProvider.isPlaying;
          return SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: StylishContainer(
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('P L A Y L I S T'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    child: StylishContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 280,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              image: DecorationImage(
                                image: AssetImage(
                                  _playlistProvider
                                      .playlist[index!].thumbnailPath,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _playlistProvider
                                          .playlist[index].artistName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _playlistProvider
                                          .playlist[index].songName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: isFav
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 32,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          size: 32,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      isFav = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    ),
                    child: Slider(
                      min: 0,
                      max: _playlistProvider.totalDuration.inSeconds.toDouble(),
                      value: sliderValue,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          _playlistProvider.seekSong(
                            Duration(
                              seconds: value.toInt(),
                            ),
                          );
                        });
                      },
                    ),
                  ),

                  // start time, shuffle button, repeat button, end time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        formatTime(_playlistProvider.currentDuration),
                      ),
                      IconButton(
                        icon: isShuffle
                            ? Icon(
                                Icons.shuffle,
                                color: Colors.blueAccent,
                              )
                            : Icon(
                                Icons.shuffle,
                              ),
                        onPressed: () {
                          setState(() {
                            isShuffle = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: isRepeat
                            ? Icon(
                                Icons.repeat,
                                color: Colors.blueAccent,
                              )
                            : Icon(
                                Icons.repeat,
                              ),
                        onPressed: () {
                          setState(() {
                            isRepeat = true;
                          });
                        },
                      ),
                      Text(
                        formatTime(_playlistProvider.totalDuration),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // previous song, pause play, skip next song
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _playlistProvider.playPreviousSong();
                              });
                            },
                            child: StylishContainer(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _playlistProvider.pauseOrResumeSong();
                                });
                              },
                              child: StylishContainer(
                                child: isPlaying
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _playlistProvider.playNextSong();
                              });
                            },
                            child: StylishContainer(
                              child: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _playlistProvider.dispose();
    super.dispose();
  }
}
