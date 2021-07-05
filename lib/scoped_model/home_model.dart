import 'package:spoon/scoped_model/base_model.dart';
import 'package:spoon/service_locator.dart';
import 'package:spoon/services/request_service.dart';

class HomeModel extends BaseModel {
  final requestService = locator<RequestService>();

  void init() {
    print('init HomeModel');

    requestService.initStreams();
  }
}