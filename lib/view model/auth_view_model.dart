import 'package:flutter/material.dart';
import '../repo/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  AuthRepo _authRepo = AuthRepo();

  UserViewModel _userViewModel = UserViewModel();

  bool _Loading = false;

  // Getter Methods
  bool get Loading => _Loading;

  // Setter Methods
  void setLoginLoading(bool newBool) {
    _Loading = newBool;
    notifyListeners();
  }

// This function is responsible for handling the login API call.
// It takes two parameters:
// - data: The login data to be sent to the API.
// - context: The context of the current screen.
  Future loginApi(dynamic data, BuildContext context) async {
    debugPrint("login api called");
    // Set the login loading state to true to show the loading indicator.
    setLoginLoading(true);

    // Call the login API with the provided data.
    _authRepo.loginApi(data).then((value) async {
      // Once the API call is successful, set the login loading state to false.
      setLoginLoading(false);

      // Show a success message using a Snackbar.
      Utils.snackBar(
          message: "Login Successful ✓", context, desc: "Sign in success!");

      // Debug print the value returned by the API call.
      debugPrint(value.toString());

      // Save User Session with Shared_Preference
      await _userViewModel.setUser(value["data"]["_token"]);
      debugPrint(value["data"]["_token"]);

      // Navigate to the home screen using the named route.
      Navigator.pushReplacementNamed(context, RoutesName.navbar);
    }).onError((error, stackTrace) {
      // If there's an error with the API call, set the login loading state to false.
      setLoginLoading(false);

      // Show an error message using a Snackbar.
      Utils.snackBar(
          message: "Incorrect Credentials",
          context,
          desc: "Verify your email & password and try again",
          isErrorMsg: true);

      // Debug print the error message.
      debugPrint(error.toString());
    });
  }
}
