import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:spoon/duration_state.dart';
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

  Color _thumbColor;

  Color get thumbColor => _thumbColor;

  set thumbColor(Color value) {
    if (_thumbColor != value) {
      _thumbColor = value;
      markNeedsPaint();
    }
  }

  double _thumbSize;

  double get thumbSize => _thumbSize;

  set thumbSize(double value) {
    if (_thumbSize != value) {
      _thumbSize = value;
      markNeedsLayout();
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
    print('current time = $value');
    if (_currentTime != value) {
      _currentTime = value;
      markNeedsPaint();
    }
  }

  RenderProgressBar({
    required Color barColor,
    required Color thumbColor,
    required double thumbSize,
    required int totalTime,
    required int currentTime,
    required Stream<DurationState> stateStream,
  })  : _barColor = barColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize,
        _totalTime = totalTime,
        _currentTime = currentTime,
        assert(totalTime > 0, 'totalTime must be an integer above 0'),
        assert(currentTime <= totalTime && currentTime >= 0,
            'currentTime must be inclusively between 0 and totalTime') {
    // print('stream aaaa');
    stateStream.listen((event) {
      this.currentTime = event.currentTime;
    });
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = 100.0;

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => thumbSize;

  @override
  double computeMaxIntrinsicHeight(double width) => thumbSize;

  double _currentThumbValue = 0.5;

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
        (size.width - (timeWidth + spacing) * 2) * (currentTime / totalTime),
        size.height / 2).translate(leftPoint.dx, 0);
    canvas.drawLine(leftPoint, playingPoint, playedBar);
    canvas.restore();
  }
}
