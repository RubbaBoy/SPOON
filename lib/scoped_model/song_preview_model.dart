import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/song.dart';

/// This class will interface with whatever music service is going on and fully
/// handle songs being played and stuff.
class SongPreviewModel extends Model {
  final progressBarModel = locator<ProgressBarModel>();
  final requestService = locator<RequestService>();

  Song? currentSong;

  void init() {
    print('init song SongPreviewModel');

    requestService.currentlyPlaying.listen((song) {
      currentSong = song;
      notifyListeners();
    });

    requestService.songPause.listen((time) =>
        progressBarModel.handler.stop(time));

    requestService.songPlay.listen((_) =>
        progressBarModel.handler.start());

    Timer(Duration(seconds: 1), () => requestService.dummyStart());
  }
}
