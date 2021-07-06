import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:spoon/utility.dart';

class SocketService {
  late final Socket _socket;

  final controller = StreamController<Json>.broadcast();

  /// Starts the socket, connecting to the TV/server program. Returns true if
  /// the connection was successful, false if otherwise.
  Future<bool> startSocket() async =>
      Socket.connect(env['TV_IP'], 8081).then((socket) {
        _socket = socket;
        socket.map(utf8.decode).map(jsonDecode).listen((json) => controller.add(json));
        return true;
      }).catchError((_, __) => false);

  /// Writes to the socket with a given [name], [uuid], and [data], and waits
  /// for a response from the server. An error is thrown if 15 seconds pass with
  /// no server response.
  Future<Json> writeSocket(
      String name, Json data, [String? uuid]) {
    final completer = Completer<Json>();
    uuid ??= genUuid();

    StreamSubscription? sub;

    var timer = Timer(Duration(seconds: 15), () {
      // If no response was received within 10 seconds, timeout
      print('Timeout request $name: $uuid');
      sub?.cancel();
      completer.completeError('Timeout request $name: $uuid');
    });

    sub = controller.stream.listen((json) {
      if (json['uuid'] == uuid) {
        sub?.cancel();
        timer.cancel();
        completer.complete(json);
      }
    });

    _socket.write(jsonEncode({'name': name, 'uuid': uuid, ...data}));

    return completer.future;
  }

  /// Listens to incoming socket messages with the name of [name]. When
  /// received, the [callback] should return a [Json] response. In this
  /// response, `name` and `uuid` are NOT required.
  void listenTo(String name, Future<Json> Function(Json json) callback) {
    controller.stream.listen((json) {
      if (json['name'] == name) {
        callback(json).then((result) => _socket.write(jsonEncode({
          'name': name,
          'uuid': json['uuid'],
          ...result
        })));
      }
    });
  }
}
