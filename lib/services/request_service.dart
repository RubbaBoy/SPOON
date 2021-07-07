import 'dart:async';

import 'package:spoon/service_locator.dart';
import 'package:spoon/services/socket_service.dart';
import 'package:spoon/song.dart';

class RequestService {
  final socketService = locator<SocketService>();

  static const baseUrl = 'http://localhost:8080';

  final _queueUpdate = StreamController<List<Song>>.broadcast();

  /// Updates the current queue
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

  /// Sends an upvote request for the given [song].
  Future<void> upvoteSong(Song song) =>
      socketService.writeSocket('upvote', {'id': song.id});

  /// Sends an downvote request for the given [song].
  Future<void> downvoteSong(Song song) =>
      socketService.writeSocket('downvote', {'id': song.id});

  /// Searches for songs with the given [string] query.
  Future<List<Song>> searchSongs(String search) async =>
      socketService.writeSocket('search', {'query': search}).then((json) =>
          json['query'].map((e) => Song.fromJson(e)).cast<Song>().toList());

  /// Sends a queue request for the given [song].
  Future<void> queueSong(Song song) async =>
      socketService.writeSocket('addQueue', {'id': song.id});

  Future<void> init() async {
    socketService.listenTo('queueUpdate', (json) async {
      _queueUpdate.add(
          json['queue'].map((e) => Song.fromJson(json)).cast<Song>().toList());
    });

    socketService.listenTo('currentlyPlaying', (json) async {
      _currentlyPlaying.add(Song.fromJson(json['song']));
    });

    socketService.listenTo('pause', (json) async {
      _songPause.add(json['time']);
    });

    socketService.listenTo('play', (json) async {
      _songPlay.add(null);
    });
  }

  /// Injects some dummy values into the streams.
  /// TODO: Remove this!
  void dummyStart() {
    print('Dummy starting!');

    _queueUpdate.add([
      Song(
          'bbb',
          'The Box',
          'Please Excuse Me for Being Antisocial',
          ['Roddy Ricch'],
          true,
          196,
          'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f',
          3,
          0),
      Song(
          'ccc',
          'The Box 2',
          'Please Excuse Me for Being Antisocial',
          ['Roddy Ricch'],
          true,
          196,
          'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f',
          2,
          4),
      Song(
          'ddd',
          'The Box 3',
          'Please Excuse Me for Being Antisocial',
          ['Roddy Ricch'],
          true,
          196,
          'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f',
          4,
          1),
    ]);

    _currentlyPlaying.add(Song(
        'aaa',
        'The Box',
        'Please Excuse Me for Being Antisocial',
        ['Roddy Ricch'],
        true,
        196,
        'https://i.scdn.co/image/ab67616d00001e02600adbc750285ea1a8da249f',
        1,
        0));

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
