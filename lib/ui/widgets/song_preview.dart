import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spoon/duration_state.dart';
import 'package:spoon/scoped_model/song_preview_model.dart';
import 'package:spoon/ui/widgets/progress_bar/progress_bar.dart';
import 'package:spoon/ui/widgets/widget_view.dart';

class SongPreview extends StatefulWidget {
  final Stream<DurationState> stateStream;

  const SongPreview({Key? key, required this.stateStream}) : super(key: key);

  @override
  _SongPreviewState createState() => _SongPreviewState();
}

class _SongPreviewState extends State<SongPreview> {
  @override
  Widget build(BuildContext context) => WidgetView<SongPreviewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, child, model) => Card(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Image.network(
                      'https://cdns-images.dzcdn.net/images/cover/4cecb47ae25837b9dd022004b5cacbdc/350x350.jpg',
                      fit: BoxFit.contain),
                ),
              ),
              ProgressBar(
                barColor: Colors.blue,
                totalTime: 75,
                currentTime: 0,
                model: model.progressBarModel,
              ),
            ],
          ),
        ),
      );
}
