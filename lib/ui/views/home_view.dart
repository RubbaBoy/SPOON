import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify_controller_app/service_locator.dart';
import 'package:spotify_controller_app/scoped_model/home_model.dart';
import 'package:spotify_controller_app/ui/views/base_view.dart';
import 'package:spotify_controller_app/ui/widgets/queue_display.dart';
import 'package:spotify_controller_app/ui/widgets/song_preview.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) => BaseView(builder:
      (BuildContext context, Widget? child, HomeModel model) => Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          child: Column(
            children: [
              SongPreview(),
              Text('Next Up'),
              QueueDisplay(),
            ],
          ),
        ),
      ),
  );
}
