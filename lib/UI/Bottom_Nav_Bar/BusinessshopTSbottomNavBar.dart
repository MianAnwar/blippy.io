import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:total_app/UI/B3_Trips/TShopMain.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/ViewProfile.dart';
import 'custom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/UI/B3_Trips/BusinessShopMain.dart';

class BusinessShopBtmNavBar extends StatefulWidget {
  final Profile profile;
  BusinessShopBtmNavBar({this.profile});

  BusinessShopBtmNavBarState createState() => BusinessShopBtmNavBarState();
}

class BusinessShopBtmNavBarState extends State<BusinessShopBtmNavBar> {
  int currentIndex = 0;
  //
  Widget callPage(int current) {
    switch (current) {
      case 0:
        // TestUser
        return new BShopMain(
          profile: widget.profile,
        );
        break;
      case 1:
        return new Search(
          companycode: widget.profile.companycode,
        );
        break;

      // case 3:
      //   return new BProducts();
      //   break;
      case 4:
        return new ViewEditProfile(profile: widget.profile);
        break;
      default:
        return new ShopMain();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Constants.basicColor.withOpacity(0.7),

      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
        activeColor: Constants.basicColor,
        color: Colors.black26,
        items: <BottomNavigationDotBarItem>[
          BottomNavigationDotBarItem(
              icon: Icons.ac_unit,
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
              icon: (Icons.search),
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
              icon: Icons.amp_stories_sharp,
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
              icon: Icons.person,
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
