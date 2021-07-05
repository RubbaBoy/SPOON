import 'package:flutter/material.dart';
import 'package:spoon/scoped_model/queue_model.dart';
import 'package:spoon/ui/widgets/itemized_song.dart';
import 'package:spoon/ui/widgets/widget_view.dart';

class QueueDisplay extends StatefulWidget {
  const QueueDisplay({Key? key}) : super(key: key);

  @override
  _QueueDisplayState createState() => _QueueDisplayState();
}

class _QueueDisplayState extends State<QueueDisplay> {
  @override
  Widget build(BuildContext context) => WidgetView<QueueModel>(
        onModelReady: (model) => model.init(),
        builder: (context, child, model) => Column(
          children: [
            for (var song in model.queue)
              ItemizedSong(model: model, song: song),
            ElevatedButton(
              onPressed: () => model.addToQueue(context),
              child: Text('Add to Queue'),
            ),
          ],
        ),
      );
}
