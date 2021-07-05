import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spoon/scoped_model/home_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/music_service.dart';
import 'package:spoon/ui/views/base_view.dart';
import 'package:spoon/ui/widgets/queue_display.dart';
import 'package:spoon/ui/widgets/song_preview.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final service = locator<MusicService>();

  @override
  Widget build(BuildContext context) => BaseView<HomeModel>(
        onModelReady: (model) => model.init(),
        builder: (context, child, model) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SongPreview(stateStream: service.stateStream),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Next Up', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.left),
                ),
                QueueDisplay(),
              ],
            ),
          ),
        ),
      );
}
