import 'package:get_it/get_it.dart';
import 'package:spoon/scoped_model/add_queue_model.dart';
import 'package:spoon/scoped_model/home_model.dart';
import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/scoped_model/queue_model.dart';
import 'package:spoon/scoped_model/song_preview_model.dart';
import 'package:spoon/services/music_service.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/services/socket_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton(() => MusicService());
  locator.registerLazySingleton(() => RequestService());
  locator.registerLazySingleton(() => SocketService());

  // Register models
  locator.registerFactory(() => HomeModel());

  // Widget models
  locator.registerFactory(() => ProgressBarModel());
  locator.registerFactory(() => SongPreviewModel());
  locator.registerFactory(() => QueueModel());
  locator.registerFactory(() => AddQueueModel());
}
