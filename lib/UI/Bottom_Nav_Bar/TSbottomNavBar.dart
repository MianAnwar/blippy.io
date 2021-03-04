import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/TSB1_Home_Screen.dart';
import 'package:total_app/UI/B2_Message/TSB2_Scanning.dart';
import 'package:total_app/UI/Bottom_Nav_Bar/shopTSbottomNavBar.dart';

import 'package:total_app/UI/B4_Review/TSB4_ReviewScreen.dart';
import 'custom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B5_Profile/TSB5_ProfileScreen.dart';

class TSBtmNavBar extends StatefulWidget {
  final String email;
  TSBtmNavBar({this.email});

  TSBtmNavBarState createState() => TSBtmNavBarState();
}

class TSBtmNavBarState extends State<TSBtmNavBar> {
  int currentIndex = 0;
  //
  Widget callPage(int current) {
    switch (current) {
      case 0:
        // TestUser
        return new TSHome(email: widget.email);
        break;
      case 1:
        return new TSScanning();
        break;
      // case 2:
      //   return new Shop();
      //   break;
      case 3:
        return new TSReviewScreen();
        break;
      case 4:
        return new TSProfileScreen(
          email: widget.email,
        );
        break;
      default:
        return new TSHome(email: widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        // color: Colors.amber,
        margin: EdgeInsets.only(top: 35),
        child: FloatingActionButton(
          backgroundColor: Constants.basicColor.withOpacity(0.9),
          onPressed: () {
            Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => ShopBtmNavBar()));
          },
          child: Text('Shop'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white, //Constants.basicColor.withOpacity(0.7),

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
            icon: Icons.maximize_rounded, //IconData(0xe0),
            onTap: () {
              // SystemChrome.setSystemUIOverlayStyle(
              //     SystemUiOverlayStyle.light.copyWith(
              //   statusBarColor: Colors.transparent,
              // ));
              // setState(() {
              //   currentIndex = 0;
              // });
              // Navigator.of(context).push(PageRouteBuilder(
              //   pageBuilder: (_, __, ___) => ShopMain(),
              // ));
            },
          ),
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
