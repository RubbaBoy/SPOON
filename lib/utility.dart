/// Takes a [seconds] amount and turns it into a readable time,
/// e.g. `125` would output `2:05`
String formatTime(int seconds) => '${seconds ~/ 60}:' + '${seconds % 60}'.padLeft(2, '0');
