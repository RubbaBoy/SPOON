import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/song.dart';
import 'package:spoon/ui/views/add_queue_view.dart';

class QueueModel extends Model {
  final requestService = locator<RequestService>();

  List<Song> queue = [];

  void init() {
    print('init QueueModel');

    requestService.queueUpdate.listen((songs) {
      print('queue update! $songs');
      queue = songs;
      notifyListeners();
    });
  }

  void addToQueue(BuildContext context) {
    print('Sending to add to queue page');
    Navigator.push(context, MaterialPageRoute(builder: (_) => QueueView()));
  }

  void upvoteSong(Song song) => requestService.upvoteSong(song);

  void downvoteSong(Song song) => requestService.downvoteSong(song);
}
