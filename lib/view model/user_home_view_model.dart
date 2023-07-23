import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/response/api_response.dart';
import '../model/providers_list_model.dart';
import '../repo/user_home_repo.dart';

class UserHomeViewModel with ChangeNotifier {
  ApiResponse<ProvidersListModel> _apiResponse = ApiResponse.loading();
  UserHomeRepo _userHomeRepo = UserHomeRepo();
  final String API_DATA = "api_data";

  // Getter Method
  ApiResponse<ProvidersListModel> get apiResponse => _apiResponse;

  Future<void> fetchProvidersList() async {
    _setApiResponse(ApiResponse.loading());

    try {
      await _userHomeRepo.fetchProvidersList().then((value) {
        _setApiResponse(ApiResponse.completed(value));

        saveApiData(value); // Api data saved into local storage
        debugPrint('Fetched Api');
      });
    } catch (error) {
      debugPrint('Error Occured');
      debugPrint(error.toString());
      _setApiResponse(ApiResponse.error(error.toString()));
    }
  }

  void _setApiResponse(ApiResponse<ProvidersListModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future saveApiData(dynamic data) async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data); // Encode data into a JSON string
    SP.setString(
        API_DATA, jsonString); // Save the JSON string to SharedPreferences
    notifyListeners();
  }

  Future getApiData() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    final String? jsonData = SP.getString(API_DATA);

    if (jsonData != null) {
      var decodedData = jsonDecode(jsonData);
      final providersListModel = ProvidersListModel.fromJson(decodedData);
      return providersListModel;
    }
  }

  Future removeApiData() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    SP.remove(API_DATA);
  }
}
