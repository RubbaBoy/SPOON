import 'dart:async';

import 'package:spoon/song.dart';

class RequestService {
  /// Updates the current queue
  final _queueUpdate = StreamController<List<Song>>.broadcast();

  Stream<List<Song>> get queueUpdate => _queueUpdate.stream;

  /// Updates the current song being played.
  final _currentlyPlaying = StreamController<Song>.broadcast();

  Stream<Song> get currentlyPlaying => _currentlyPlaying.stream;

  /// When a number comes in, the song will be paused at that current second
  /// marker (for consistency across clients).
  final _songPause = StreamController<int>.broadcast();

  Stream<int> get songPause => _songPause.stream;

  /// When a song starts playing
  final _songPlay = StreamController.broadcast();

  Stream get songPlay => _songPlay.stream;

  void initStreams() {
    // TODO: Initialize the socket and streams
  }

  /// Injects some dummy values into the streams.
  /// TODO: Remove this!
  void dummyStart() {
    print('Dummy starting!');

    _queueUpdate.add([
      Song('bbb', 'The Box', 'Please Excuse Me for Being Antisocial', 'Roddy Ricch', true, 196, 'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f', 3, 0),
      Song('ccc', 'The Box 2', 'Please Excuse Me for Being Antisocial', 'Roddy Ricch', true, 196, 'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f', 2, 4),
      Song('ddd', 'The Box 3', 'Please Excuse Me for Being Antisocial', 'Roddy Ricch', true, 196, 'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f', 4, 1),
    ]);

    _currentlyPlaying.add(Song('aaa', 'The Box', 'Please Excuse Me for Being Antisocial', 'Roddy Ricch', true, 196, 'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f', 1, 0));

    _songPlay.add(null);

    Timer(Duration(seconds: 10), () => _songPause.add(10));
  }

  void close() {
    _queueUpdate.close();
    _currentlyPlaying.close();
    _songPause.close();
    _songPlay.close();
  }
}
