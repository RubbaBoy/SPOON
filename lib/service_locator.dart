import 'package:get_it/get_it.dart';
import 'package:spoon/scoped_model/home_model.dart';
import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/scoped_model/song_preview_model.dart';
import 'package:spoon/services/music_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton(() => MusicService());

  // Register models
  locator.registerFactory(() => HomeModel());

  // A widget models
  locator.registerFactory(() => ProgressBarModel());
  locator.registerFactory(() => SongPreviewModel());
}
