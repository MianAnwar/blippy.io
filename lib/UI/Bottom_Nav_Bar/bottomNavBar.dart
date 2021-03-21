import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:total_app/UI/B2_Message/BusinessB2_Scanning.dart';
import 'package:total_app/UI/B4_Review/B4_ReviewScreen.dart';
import 'custom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B5_Profile/B5_ProfileScreen.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/UI/Bottom_Nav_Bar/BusinessshopTSbottomNavBar.dart';

class BottomNavBar extends StatefulWidget {
  final Profile profile;
  BottomNavBar({this.profile});

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  //
  Widget callPage(int current) {
    switch (current) {
      case 0:
        // TestUser
        return new Home(
          profile: widget.profile,
        );
        break;
      case 1:
        return new BScanning(
          companycode: widget.profile.companycode,
        );
        break;

      case 3:
        return new ReviewScreen(
          companycode: widget.profile.companycode,
        );
        break;
      case 4:
        return new ProfileScreen(
          profile: widget.profile,
        );
        break;
      default:
        return new Home(
          profile: widget.profile,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        // color: Colors.amber,
        margin: EdgeInsets.only(top: 35),
        child: FloatingActionButton.extended(
          backgroundColor: Constants.basicColor.withOpacity(0.9),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => BusinessShopBtmNavBar(
                      profile: widget.profile,
                    )));
          },
          label: Text('ShopFront'),
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
              icon: (Icons.integration_instructions),
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
            icon: Icons.maximize_rounded,
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
              icon: Icons.receipt,
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
