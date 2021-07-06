import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spoon/scoped_model/base_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/song.dart';

class AddQueueModel extends BaseModel {
  final requestService = locator<RequestService>();
  final searchController = TextEditingController();
  final FToast fToast = FToast();

  List<Song> displayResults = [];
  Timer? waiting;

  void init(BuildContext context) {
    print('init AddQueueModel');

    fToast.init(context);
  }

  void clear() {
    searchController.clear();
  }

  void onUpdate(String text) {
    waiting?.cancel();
    waiting = Timer(Duration(seconds: 1), () => requestService.searchSongs(text)
        .then((songs) {
          displayResults = songs;
          notifyListeners();
        }));
  }

  void queueSong(Song song) => requestService.queueSong(song);
}
