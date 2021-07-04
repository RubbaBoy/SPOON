import 'package:flutter/material.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/music_service.dart';

class QueueDisplay extends StatefulWidget {
  const QueueDisplay({Key? key}) : super(key: key);

  @override
  _QueueDisplayState createState() => _QueueDisplayState();
}

class _QueueDisplayState extends State<QueueDisplay> {
  final service = locator<MusicService>();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Card(
        child: Text('one'),
      ),
      Card(
        child: Text('two'),
      ),
      Card(
        child: Text('three'),
      ),
    ],
  );
}
