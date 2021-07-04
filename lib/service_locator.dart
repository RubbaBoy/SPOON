import 'package:get_it/get_it.dart';
import 'package:spotify_controller_app/scoped_model/home_model.dart';
import 'package:spotify_controller_app/services/music_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton(() => MusicService());

  // Register models
  locator.registerFactory(() => HomeModel());
}
