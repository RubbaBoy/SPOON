import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spoon/scoped_model/queue_model.dart';
import 'package:spoon/song.dart';

class ItemizedSong extends StatelessWidget {
  final QueueModel? model;
  final bool enableVoting;
  final Song song;

  const ItemizedSong(
      {Key? key, this.model, required this.song, this.enableVoting = true})
      : assert(enableVoting == (model != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) => getDismissible(
        Card(
          child: ListTile(
            leading: Container(
              width: 56,
              height: 56,
              child: Image.network(song.imageUrl, fit: BoxFit.contain),
            ),
            title: Text(song.name),
            subtitle: Text(song.artists.join(', ')),
          ),
        ),
      );

  Widget getDismissible(Widget child) => enableVoting
      ? Dismissible(
          key: ObjectKey(song),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              model?.upvoteSong(song);
            } else if (direction == DismissDirection.startToEnd) {
              model?.downvoteSong(song);
            }

            return false;
          },
          background: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Icon(Icons.arrow_upward, color: Colors.green),
              ),
            ],
          ),
          secondaryBackground: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Icon(Icons.arrow_downward, color: Colors.redAccent),
              ),
            ],
          ),
          child: child,
        )
      : child;
}
