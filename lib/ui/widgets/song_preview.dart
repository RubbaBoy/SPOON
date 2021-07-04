import 'package:flutter/material.dart';
import 'package:spoon/duration_state.dart';
import 'package:spoon/ui/widgets/progress_bar/progress_bar.dart';

class SongPreview extends StatefulWidget {
  final Stream<DurationState> stateStream;

  const SongPreview({Key? key, required this.stateStream}) : super(key: key);

  @override
  _SongPreviewState createState() => _SongPreviewState();
}

class _SongPreviewState extends State<SongPreview> {
  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            // Center(
            //   child: Container(
            //     child: Image.network('https://cdns-images.dzcdn.net/images/cover/4cecb47ae25837b9dd022004b5cacbdc/350x350.jpg', fit: BoxFit.contain),
            //   ),
            // ),
                  ProgressBar(
                    barColor: Colors.blue,
                    thumbColor: Colors.red,
                    thumbSize: 20.0,
                    totalTime: 10,
                    currentTime: 0,
                    stateStream: widget.stateStream,
                  ),
          ],
        ),
      );
}
