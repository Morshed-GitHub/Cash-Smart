import 'package:assignment_project/data/network/base_api_service.dart';
import 'package:flutter/widgets.dart';
import '../data/network/network_api_service.dart';
import '../res/app_url.dart';

class AuthRepo {
  BaseApiService _apiService = NetworkApiService();

  Future loginApi(dynamic data) async {
    debugPrint("login api called auth repo");
    try {
      final response = await _apiService.getPostApiResponse(AppUrl.login, data);
      return response;
    } catch (exception) {
      throw exception.toString();
    }
  }
}
