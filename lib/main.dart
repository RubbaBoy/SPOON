import 'package:flutter/material.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';
import 'package:spoon/services/socket_service.dart';
import 'package:spoon/ui/views/home_view.dart';

Future<void> main() async {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final socketService = locator<SocketService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPOON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: socketService.startSocket(),
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
