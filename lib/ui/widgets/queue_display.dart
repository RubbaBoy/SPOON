import 'package:flutter/material.dart';
import 'package:spoon/scoped_model/queue_model.dart';
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
          Card(
            child: Text('${song.name}: ${song.id}'),
          ),
      ],
    ),
  );
}
