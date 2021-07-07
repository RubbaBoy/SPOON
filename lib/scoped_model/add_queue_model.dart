import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onUpdate(String text) {
    waiting?.cancel();
    waiting = Timer(Duration(seconds: 1), () => onSubmit(text));
  }

  void onSubmit(String text) {
    waiting?.cancel();
    requestService.searchSongs(text).then((songs) {
      displayResults = songs;
      notifyListeners();
    });
  }

  void queueSong(Song song) {
    requestService.queueSong(song);

    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.lightBlueAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text('Added to queue'),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
