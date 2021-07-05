class ProgressBarModel {
  ProgressHandler? handler;
}

class ProgressHandler {
  final Function() start;
  final Function(int) stop;

  ProgressHandler({required this.start, required this.stop});
}
