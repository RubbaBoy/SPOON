import 'package:flutter/material.dart';
import 'package:spotify_controller_app/service_locator.dart';
import 'package:spotify_controller_app/services/music_service.dart';
import 'package:spotify_controller_app/ui/widgets/progress_bar/progress_bar.dart';

class SongPreview extends StatefulWidget {
  const SongPreview({Key? key}) : super(key: key);

  @override
  _SongPreviewState createState() => _SongPreviewState();
}

class _SongPreviewState extends State<SongPreview> {
  final service = locator<MusicService>();

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
          totalTime: 75,
          currentTime: 15,
        ),
      ],
    ),
  );
}
