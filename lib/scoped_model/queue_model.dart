import 'package:scoped_model/scoped_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/song.dart';

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
}
