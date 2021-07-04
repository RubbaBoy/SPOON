import 'package:flutter/material.dart';

class RenderProgressBar extends RenderBox {

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
  })  : _barColor = barColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize,
        _totalTime = totalTime,
        _currentTime = currentTime;

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



    var _widthPainter = TextPainter(text: TextSpan(text: '00:00'), textDirection: TextDirection.rtl)
      ..layout();
    var timeWidth = _widthPainter.width;
    var timeHeight = _widthPainter.height;

    print('timeWidth = $timeWidth');

    TextPainter(text: TextSpan(text: '0:00', style: new TextStyle(color: Colors.black)), textDirection: TextDirection.rtl)
      ..layout()
      ..paint(canvas, Offset(0, size.height / 2 - timeHeight / 2));

    TextPainter(text: TextSpan(text: '0:00', style: new TextStyle(color: Colors.black)), textDirection: TextDirection.rtl)
      ..layout()
      ..paint(canvas, Offset(0, size.height / 2 - timeHeight / 2));

    // paint bar
    final barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 5;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width, size.height / 2);
    canvas.drawLine(point1, point2, barPaint);

    // paint thumb
    final thumbPaint = Paint()..color = thumbColor;
    final thumbDx = _currentThumbValue * size.width;
    final center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbSize / 2, thumbPaint);
    canvas.restore();
  }
}