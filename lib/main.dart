import 'package:flutter/material.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/services/socket_service.dart';
import 'package:spoon/ui/views/home_view.dart';

Future<void> main() async {
  setupLocator();
  final socketService = locator<SocketService>();
  final requestService = locator<RequestService>();
  runApp(MyApp(socketStartFuture: socketService.startSocket()
      .then((value) async {
        await requestService.init();
        return value;
      })));
}

class MyApp extends StatelessWidget {

  final Future<bool> socketStartFuture;

  const MyApp({Key? key, required this.socketStartFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPOON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: socketStartFuture,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  color: ThemeData.light().scaffoldBackgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              default:
                if (snapshot.data ?? false) {
                  return HomeView();
                } else {
                  return Center(child: Text('Can\'t connect!'));
                }
            }
          }),
    );
  }
}
