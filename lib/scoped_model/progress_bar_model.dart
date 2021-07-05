import 'package:scoped_model/scoped_model.dart';

class ProgressBarModel extends Model {
  late ProgressHandler handler;
}

class ProgressHandler {
  final Function() start;
  final Function(int) stop;

  ProgressHandler({required this.start, required this.stop});
}
