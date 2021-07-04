import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:spoon/duration_state.dart';
import 'package:spoon/ui/widgets/progress_bar/_render_progress_bar.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    Key? key,
    required this.barColor,
    required this.thumbColor,
    required this.totalTime,
    required this.currentTime,
    required this.stateStream,
    this.thumbSize = 20.0,
  }) : super(key: key);

  final Stream<DurationState> stateStream;
  final Color barColor;
  final Color thumbColor;
  final double thumbSize;
  final int totalTime;
  final int currentTime;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
      totalTime: totalTime,
      currentTime: currentTime,
      stateStream: stateStream,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderProgressBar renderObject) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}