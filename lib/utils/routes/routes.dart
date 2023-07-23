import 'package:flutter/cupertino.dart';
import '../../view/bottom_navigator_screen.dart';
import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/profile_screen.dart';
import '../../view/support_screen.dart';
import '../../view/user_home_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: LoginScreen(),
          ),
        );
      case RoutesName.home:
        return CupertinoPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RoutesName.userHome:
        return CupertinoPageRoute(
          builder: (context) => UserHomeScreen(),
        );
      case RoutesName.profile:
        return CupertinoPageRoute(
          builder: (context) => ProfileScreen(),
        );

      // Logout Transition Animation
      case RoutesName.navbar:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: BottomNavigatorScreen(),
          ),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => FaultRouteScreen(),
        );
    }
  }
}
