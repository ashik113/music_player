// ignore_for_file: unused_field

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/songs.dart';

class PlaylistProvider extends ChangeNotifier {
  static PlaylistProvider instance = PlaylistProvider();
  int? _currentSongIndex;

  //getters
  int? get currentSongIndex => _currentSongIndex;
  List<Song> get playlist => _playlist;

  //setters
  set currentSongIndex(int? newIndex) {
    notifyListeners();
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      playSong();
    }
    notifyListeners();
  }

  final List<Song> _playlist = [
    Song(
      songName: "Shape of You",
      artistName: "Ed Sheeran",
      thumbnailPath: "assets/images/shape_of_you.jpg",
      audioPath: "audio/shape_of_you.mp3",
    ),
    Song(
      songName: "Someone You Loved",
      artistName: "Lewis Capaldi",
      thumbnailPath: "assets/images/someone_you_loved.jpg",
      audioPath: "audio/someone_you_loved.mp3",
    ),
    Song(
      songName: "Blinding Lights",
      artistName: "The Weeknd",
      thumbnailPath: "assets/images/blinding_lights.jpg",
      audioPath: "audio/blinding_lights.mp3",
    ),
  ];

  //audio player instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //initially not playing
  late bool _isPlaying;

  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  bool get isPlaying => _isPlaying;

  PlaylistProvider() {
    _isPlaying = false;
    listenToDuration();
    notifyListeners();
  }

  void playSong() async {
    final String path = playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pauseSong() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resumeSong() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResumeSong() async {
    if (_isPlaying == true) {
      pauseSong();
    } else {
      resumeSong();
    }
  }

  void seekSong(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
    _audioPlayer.stop();
    playSong();
    notifyListeners();
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      _currentSongIndex = _currentSongIndex;
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
    playSong();
    notifyListeners();
  }

  void listenToDuration() {
    //total duration
    _audioPlayer.onDurationChanged.listen((event) {
      _totalDuration = event;
      notifyListeners();
    });

    //current duration
    _audioPlayer.onPositionChanged.listen((event) {
      _currentDuration = event;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
      notifyListeners();
    });
  }
}
