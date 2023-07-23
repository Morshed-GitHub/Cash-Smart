import 'package:assignment_project/view/profile_screen.dart';
import 'package:assignment_project/view/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view model/bottom_nav_bar_view_model.dart';
import '../view model/services/services.dart';
import 'home_screen.dart';
import 'user_home_screen.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigatorScreen createState() => _BottomNavigatorScreen();
}

class _BottomNavigatorScreen extends State<BottomNavigatorScreen> {
  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    FaultRouteScreen(),
  ];

  Future<void> assignHomeScreenIfUserSessionValid() async {
    // If user is logged in then "UserHomeScreen", otherwise "HomeScreen"
    bool userLoggedIn = await Services().checkUserSession();
    debugPrint("User Session:" + userLoggedIn.toString());
    screens[0] = (userLoggedIn ? UserHomeScreen() : HomeScreen());
    // Note that modifying individual elements within a "final" list is allowed,
    // but assigning a completely "new" list to the "final" list named "screens",
    // is not allowed, once it is declared as "final".

    // Initially refresh the screen to show the appropriate home screen as per user session
    setState(() {
      debugPrint("setState Called");
    });
  }

  @override
  void initState() {
    super.initState();
    assignHomeScreenIfUserSessionValid();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build called');

    return Scaffold(
      bottomNavigationBar: Consumer<BottomNavigatorViewModel>(
        builder: (context, value, child) =>
            _buildBottomNavigationBar(bottomNavBarModel: value),
      ),
      body: Consumer<BottomNavigatorViewModel>(
        builder: (context, value, child) =>
            // Initially loads all the screens and store them on "Stack".
            // When user navigate them through "bottomNavigationBar", it
            // wont load every time, just navigate to the already loaded
            // scree. Improves user experience.
            IndexedStack(
          index: value.currentIndex,
          children: screens,
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(
      {required BottomNavigatorViewModel bottomNavBarModel}) {
    return BottomNavigationBar(
      currentIndex: bottomNavBarModel.currentIndex,
      onTap: bottomNavBarModel.setIndex,
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 32), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp, size: 32), label: 'Profile'),
        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent_sharp, size: 32),
          label: 'Support',
        ),
      ],
    );
  }
}
