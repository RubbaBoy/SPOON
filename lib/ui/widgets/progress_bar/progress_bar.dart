import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:spoon/scoped_model/progress_bar_model.dart';
import 'package:spoon/ui/widgets/progress_bar/_render_progress_bar.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    Key? key,
    required this.barColor,
    required this.totalTime,
    required this.currentTime,
    required this.model,
  }) : super(key: key);

  final ProgressBarModel model;
  final Color barColor;
  final int totalTime;
  final int currentTime;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      totalTime: totalTime,
      currentTime: currentTime,
      model: model,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderProgressBar renderObject) {
    renderObject
      ..barColor = barColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // TODO: Update these
    properties.add(ColorProperty('barColor', barColor));
  }
}