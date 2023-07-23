import 'package:flutter/material.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../model/provider_model.dart';
import '../res/app_url.dart';

class HomeRepo {
  BaseApiService _apiService = NetworkApiService();

  Future<ProviderModel> fetchProviderList() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(AppUrl.provider);
      debugPrint("Api Hitted");
      return ProviderModel.fromJson(response);
    } catch (exception) {
      throw exception.toString();
    }
  }
}
