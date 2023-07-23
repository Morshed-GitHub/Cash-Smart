import 'package:flutter/material.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../model/providers_list_model.dart';
import '../res/app_url.dart';
import '../view model/user_view_model.dart';

class UserHomeRepo {
  BaseApiService _apiService = NetworkApiService();

  Future<ProvidersListModel> fetchProvidersList() async {
    try {
      String token = await UserViewModel().getUser();

      // Checking token in console, in order to check the procedure flow
      debugPrint("Token: $token");

      // In Case, token got null, then...
      if (token == "null" || token == "") {
        throw Exception("Token Got NULL!");
      }

      Map<String, dynamic> _headers = {
        'Authorization':
            'Bearer $token', // Getting token and pass it through headers as required
      };

      dynamic response =
          await _apiService.getGetApiResponse(AppUrl.providersList, _headers);
      debugPrint("Api Hitted");
      return ProvidersListModel.fromJson(response);
    } catch (exception) {
      throw exception.toString();
    }
  }
}
