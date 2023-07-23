import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/components/custom_clipper.dart';
import '../res/components/headline.dart';
import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view model/bottom_nav_bar_view_model.dart';
import '../view model/services/services.dart';
import '../view model/user_home_view_model.dart';
import '../view model/user_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          ProfileHeader(height: _height),
          ActivitiesSection(height: _height),
        ],
      ),
    );
  }
}

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({
    super.key,
    required double height,
  }) : _height = height;

  final double _height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: listOfActivities(),
    );
  }

  Column listOfActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Headline(title: "Your activities", color: Colors.black),
        SizedBox(height: _height * .04),
        ActivityListTile(
          icon: Icons.bar_chart_rounded,
          iconColor: Colors.blue,
          title: "Your activity",
          subtitle: "Tracked and confirmed cashback",
        ),
        SizedBox(height: _height * .04),
        ActivityListTile(
          icon: Icons.flag_outlined,
          iconColor: Colors.blue,
          title: "Claims",
          subtitle: "Check the status of your claims",
        ),
        SizedBox(height: _height * .04),
        ActivityListTile(
          icon: Icons.rocket_launch_sharp,
          iconColor: Colors.redAccent,
          title: "Boosts",
          subtitle: "All of your boosts",
        ),
        SizedBox(height: _height * .04),
        ActivityListTile(
          icon: Icons.storage_sharp,
          iconColor: Colors.blue,
          title: "Bonus cashback",
          subtitle: "All of your Cash Smart Bonuses",
        ),
        SizedBox(height: _height * .04),
      ],
    );
  }
}

class ActivityListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const ActivityListTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon Part
        Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
        SizedBox(width: 20),

        // Text Part
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required double height,
  }) : _height = height;

  final double _height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
          CustomCircleClipper(), // To make custom circle shape in below part of the container

      child: Container(
        height: _height * .6,
        color: Colors.blue,
        child: profileItems(context),
      ),
    );
  }

  Padding profileItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          topBar(context),
          options(),
        ],
      ),
    );
  }

  Column options() {
    return Column(
      children: [
        CircleWidget(radius: 50),
        SizedBox(height: _height * .03),
        buildAccountBalaceDigit(),
        SizedBox(height: _height * .01),
        accountBalaceText(),
        SizedBox(height: _height * .02),
        RoundButton(
          title: "Withdraw Balance",
          onTap: () {},
          textColor: Colors.blue,
          buttonColor: Colors.white,
        ),
        SizedBox(height: _height * .1)
      ],
    );
  }

  Text accountBalaceText() {
    return Text(
      "Account Balance",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        // fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildAccountBalaceDigit() {
    return Text(
      "£2.06",
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Profile",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () {
              showPopupMenu(context); // Logout pop up menu
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  void showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          1000.0, 70.0, 0.0, 0.0), // Allign with setting button
      items: [
        PopupMenuItem(
          value: "logout",
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.blue),
            title: Text('Logout'),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) async {
      if (value == null) return;
      switch (value) {
        case 'logout':
          // If user logged in, only that time he can logged out from app
          bool isLoggedIn = await Services().checkUserSession();
          if (isLoggedIn) {
            await logout(context);
          } else {
            Utils.snackBar(message: "Already Logged Out!!", context);
          }
          break;
        default:
      }
    });
  }

  Future<void> logout(BuildContext context) async {
    // In order to show the guest home screen just after clicking log out button,
    // otherwise navigate to the same page "profile screen".
    BottomNavigatorViewModel bottomNavBarModel =
        Provider.of<BottomNavigatorViewModel>(context,
            listen:
                false); // listen must be "false" to achieve this functionality
    bottomNavBarModel.setIndex(0); // set guest home screen

    // Implemented logout logic here
    Navigator.pushReplacementNamed(context, RoutesName.navbar);
    await UserHomeViewModel().removeApiData(); // Removed Api Saved Local Data
    await UserViewModel().removeUser(); // User Session Closed
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;

  const CircleWidget({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
          color: Colors.blue.shade400,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3)),
      child: Center(
        child: Text(
          "CS",
          style: TextStyle(
            color: Colors.white,
            fontSize: radius,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
