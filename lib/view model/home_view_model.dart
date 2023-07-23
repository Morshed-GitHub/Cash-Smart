import 'package:assignment_project/model/provider_model.dart';
import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../repo/home_repo.dart';

class HomeViewModel with ChangeNotifier {
  ApiResponse<ProviderModel> _apiResponse = ApiResponse.loading();
  HomeRepo _homeRepo = HomeRepo();

  // Getter Method
  ApiResponse<ProviderModel> get apiResponse => _apiResponse;

  Future<void> fetchProviderList() async {
    _setApiResponse(ApiResponse.loading());

    try {
      await _homeRepo.fetchProviderList().then((value) {
        // if successfully fetched the data, then...
        _setApiResponse(ApiResponse.completed(
            value)); // set the data into apiResponse from where we will access.
        debugPrint('Fetched Api');
      });
    } catch (error) {
      // otherwise throw error
      debugPrint('Error Occured' + error.toString());
      _setApiResponse(ApiResponse.error(error.toString()));
    }
  }

  // Set Api response according to scenarios like (loading, completed, error)
  void _setApiResponse(ApiResponse<ProviderModel> response) {
    _apiResponse = response;
    notifyListeners();
  }
}
