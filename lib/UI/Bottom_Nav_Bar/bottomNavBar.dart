import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:total_app/UI/B2_Message/B2_MessageScreen.dart';
import 'package:total_app/UI/B3_Trips/B3_TripScreen.dart';
import 'package:total_app/UI/B4_Review/B4_ReviewScreen.dart';
import 'package:total_app/UI/B5_Profile/B5_ProfileScreen.dart';
import 'custom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:total_app/constants.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar();

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home();
        break;
      case 1:
        return new Scanning();
        break;
      case 2:
        return new trip();
        break;
      case 3:
        return new ReviewScreen();
        break;
      case 4:
        return new Profile();
        break;
      default:
        return new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.basicColor,
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
        activeColor: Constants.basicColor,
        color: Colors.black26,
        items: <BottomNavigationDotBarItem>[
          BottomNavigationDotBarItem(
              icon: Icons.home, // IconData(0xe900, fontFamily: 'home'),
              onTap: () {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                ));
                setState(() {
                  currentIndex = 0;
                });
              }),
          BottomNavigationDotBarItem(
              icon: (Icons.qr_code_scanner),
              onTap: () {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                ));
                setState(() {
                  currentIndex = 1;
                });
              }),
          BottomNavigationDotBarItem(
              icon: Icons.storefront,
              onTap: () {
                setState(() {
                  SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle.light.copyWith(
                    statusBarColor: Colors.transparent,
                  ));
                  currentIndex = 2;
                });
              }),
          BottomNavigationDotBarItem(
              icon: Icons.star_rate_outlined,
              onTap: () {
                setState(() {
                  SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle.light.copyWith(
                    statusBarColor: Colors.transparent,
                  ));
                  currentIndex = 3;
                });
              }),
          BottomNavigationDotBarItem(
              icon: Icons.more_horiz,
              onTap: () {
                setState(() {
                  SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle.light.copyWith(
                    statusBarColor: Colors.transparent,
                  ));
                  currentIndex = 4;
                });
              }),
        ],
      ),
    );
  }
}
