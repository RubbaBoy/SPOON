import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/service_locator.dart';

/// This class will interface with whatever music service is going on and fully
/// handle songs being played and stuff.
class SongPreviewModel {
  final progressBarModel = locator<ProgressBarModel>();

  void start() {
    progressBarModel.handler?.start();
  }
}
