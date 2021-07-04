import 'dart:async';

import 'package:spoon/duration_state.dart';

class MusicService {
  final Stream<DurationState> stateStream = Stream.periodic(Duration(seconds: 1), (i) => DurationState(i));

  // int currentlyPlaying = 0;
  //
  // void start() {
  //   Timer.periodic(Duration(seconds: 1), (t) {
  //     if (currentlyPlaying == 75) {
  //       t.cancel();
  //       return;
  //     }
  //
  //     currentlyPlaying++;
  //   });
  // }

}
