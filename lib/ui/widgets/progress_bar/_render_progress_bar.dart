import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/utility.dart';

class RenderProgressBar extends RenderBox {
  final hms = DateFormat.Hms();

  Color _barColor;

  Color get barColor => _barColor;

  set barColor(Color value) {
    if (_barColor != value) {
      _barColor = value;
      markNeedsPaint();
    }
  }

  int _totalTime;

  int get totalTime => _totalTime;

  set totalTime(int value) {
    if (_totalTime != value) {
      _totalTime = value;
      markNeedsPaint();
    }
  }

  int _currentTime;

  int get currentTime => _currentTime;

  set currentTime(int value) {
    if (_currentTime != value) {
      _currentTime = value;
      markNeedsPaint();
    }
  }

  /// The timer that controls the progression of the progress bar.
  Timer? timer;
  ProgressBarModel model;

  RenderProgressBar({
    required Color barColor,
    required int totalTime,
    required int currentTime,
    required this.model,
  })  : _barColor = barColor,
        _totalTime = totalTime,
        _currentTime = currentTime,
        assert(totalTime > 0, 'totalTime must be an integer above 0'),
        assert(currentTime <= totalTime && currentTime >= 0,
            'currentTime must be inclusively between 0 and totalTime') {
    model.handler = ProgressHandler(start: start, stop: stop);
  }

  double progressTime = 0;

  /// Starts the progression
  void start() {
    progressTime = currentTime.toDouble();
    timer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      progressTime += 0.25;
      currentTime = progressTime.floor();
      markNeedsPaint();
      if (currentTime >= totalTime) {
        timer.cancel();
      }
    });
  }

  /// Stops the progression, with an optional absolute stop time.
  void stop([int? seconds]) {
    timer?.cancel();
    if (seconds != null) {
      progressTime = seconds.toDouble();
      currentTime = seconds;
    }
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredSize = Size(desiredWidth, _minDesiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = 100.0;
  static const _minDesiredHeight = 25.0;

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _minDesiredHeight;

  @override
  double computeMaxIntrinsicHeight(double width) => _minDesiredHeight;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    var _widthPainter = TextPainter(
        text: TextSpan(text: '00:00'), textDirection: TextDirection.ltr)
      ..layout();
    var timeWidth = _widthPainter.width;
    var timeHeight = _widthPainter.height;

    var leftPainter = TextPainter(
        text: TextSpan(
            text: formatTime(currentTime),
            style: new TextStyle(color: Colors.black)),
        textDirection: TextDirection.rtl)
      ..layout();

    leftPainter.paint(
        canvas,
        Offset(
            timeWidth - leftPainter.width, size.height / 2 - timeHeight / 2));

    TextPainter(
        text: TextSpan(
            text: formatTime(totalTime),
            style: new TextStyle(color: Colors.black)),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas,
          Offset(size.width - timeWidth, size.height / 2 - timeHeight / 2));

    var spacing = 10;

    // paint bar
    final barPaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 5;

    final leftPoint = Offset(timeWidth + spacing, size.height / 2);
    final rightPoint =
        Offset(size.width - timeWidth - spacing, size.height / 2);
    canvas.drawLine(leftPoint, rightPoint, barPaint);

    final playedBar = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 5;

    final playingPoint = Offset(
            (size.width - (timeWidth + spacing) * 2) *
                (progressTime / totalTime),
            size.height / 2)
        .translate(leftPoint.dx, 0);
    canvas.drawLine(leftPoint, playingPoint, playedBar);
    canvas.restore();
  }
}
