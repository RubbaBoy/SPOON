import 'dart:io';

import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

Map<String, dynamic> get env => Platform.environment;

Json get emptyJson => {};

typedef Json = Map<String, dynamic>;

String genUuid() => uuid.v4();

/// Takes a [seconds] amount and turns it into a readable time,
/// e.g. `125` would output `2:05`
String formatTime(int seconds) => '${seconds ~/ 60}:' + '${seconds % 60}'.padLeft(2, '0');
