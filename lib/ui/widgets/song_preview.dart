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
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: model.currentSong == null
                        ? Container(color: Colors.grey)
                        : Image.network(model.currentSong!.imageUrl,
                            fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ProgressBar(
                    barColor: Colors.blue,
                    totalTime: 75,
                    currentTime: 0,
                    model: model.progressBarModel,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(model.currentSong?.name ?? '-',
                      style: Theme.of(context).textTheme.headline4),
                ),
                Text(model.currentSong?.artist ?? '-',
                    style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
        ),
      );
}
