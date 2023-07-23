import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../res/components/check_circle_icon.dart';
import '../res/components/frosted_glass_box.dart';
import '../res/components/headline.dart';
import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Provider
  ValueNotifier<bool> _obscurePass = ValueNotifier<bool>(true);

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  Map<String, dynamic> getUserCredentials() {
    return {
      "email": _emailController.text.trim().toString(),
      "password": _passwordController.text.trim().toString(),
    };
    // trim() method removes any leading (front) or trailing (back) spaces from user input before using it in the application
  }

  void TextFieldValidate() {
    if (_emailController.text.isEmpty) {
      Utils.snackBar(message: "Email can't be empty!", context);
    } else if (!_emailController.text.contains("@")) {
      Utils.snackBar(message: "Email must contain @", context);
    } else if (_passwordController.text.isEmpty) {
      Utils.snackBar(message: "Password can't be empty!", context);
    } else if (_passwordController.text.length < 6) {
      Utils.snackBar(message: "Password must be more than 6 letter's", context);
    } else {
      final _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _authViewModel.loginApi(getUserCredentials(), context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obscurePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: FrostedGlassBox(
          height: _height * .7,
          width: _width < 450 ? double.infinity : 480,
          child: login(_height, context),
        ),
      ),
    );
  }

  Padding login(double _height, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
        child: ListView(shrinkWrap: true, children: [
          Column(
            children: [
              CheckCircleIcon(),
              SizedBox(height: _height * .03),
              Headline(title: "Welcome!!"),
              SizedBox(height: _height * .04),
              email(),
              SizedBox(height: _height * .02),
              password(),
              SizedBox(height: _height * .05),
              Consumer<AuthViewModel>(
                builder: (context, value, child) {
                  return RoundButton(
                      title: "Sign in",
                      loading: value.Loading,
                      textColor: Colors.white,
                      onTap: () {
                        TextFieldValidate();
                      });
                },
              ),
              SizedBox(height: _height * .03),
              buildForgotPasswordOption(context),
              SizedBox(height: _height * .03),
              buildGuestAccessOption(context),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildGuestAccessOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.navbar);
      },
      child: const Text(
        "Browse As Guest",
        style: TextStyle(
          color: Colors.amberAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildForgotPasswordOption(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ValueListenableBuilder<bool> password() {
    return ValueListenableBuilder(
      valueListenable: _obscurePass,
      builder: (context, value, child) {
        return TextField(
          controller: _passwordController,
          obscureText: value,
          focusNode: _passwordFocusNode,
          decoration: InputDecoration(
            hintText: "Enter Your Password",
            prefixIcon: Icon(Icons.lock_open_outlined),
            suffixIcon: InkWell(
              onTap: () {
                _obscurePass.value = !_obscurePass.value;
              },
              child: Icon(
                _obscurePass.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        );
      },
    );
  }

  TextField email() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      onSubmitted: (value) {
        // After submitting email, click done on keyboard, focus on the password bar
        Utils.changeFocusNode(context,
            current: _emailFocusNode, next: _passwordFocusNode);
      },
      decoration: InputDecoration(
        hintText: "Enter Your Email",
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }
}
