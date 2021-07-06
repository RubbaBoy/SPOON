import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spoon/scoped_model/add_queue_model.dart';
import 'package:spoon/scoped_model/home_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/music_service.dart';
import 'package:spoon/ui/views/base_view.dart';
import 'package:spoon/ui/widgets/itemized_song.dart';
import 'package:spoon/ui/widgets/queue_display.dart';
import 'package:spoon/ui/widgets/song_preview.dart';

class QueueView extends StatefulWidget {
  @override
  _QueueViewState createState() => _QueueViewState();
}

class _QueueViewState extends State<QueueView> {
  final service = locator<MusicService>();

  @override
  Widget build(BuildContext context) => BaseView<AddQueueModel>(
        onModelReady: (model) => model.init(context),
        builder: (context, child, model) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextField(
                            onChanged: model.onUpdate,
                            onSubmitted: model.onSubmit,
                            controller: model.searchController,
                            decoration: InputDecoration(
                              hintText: 'Search songs',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: model.clear,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var song in model.displayResults)
                      InkWell(
                        child: ItemizedSong(song: song, enableVoting: false),
                        onTap: () => model.queueSong(song),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
