import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Role { Owner, RegularStaff, DesignatedStaff }

class Constants {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static String userName;
/////////////////////////////////////////
//////////< Shared Preferences >/////////
/////////////////////////////////////////
  static SharedPreferences pref;
  static Future initailizeSP() async {
    Constants.pref = await SharedPreferences.getInstance();
  }

  static Future setEmail(String email) async {
    await Constants.pref.setString('email', email);
  }

  static String getEmail() {
    return Constants.pref.getString('email');
  }

  static void logoutEmailSP() {
    Constants.pref.remove('email');
  }

  // static Future setDeshNo(int no) async {
  //   await Constants.pref.setInt('no', no);
  // }

  // static int getDeshNo() {
  //   return Constants.pref.getInt('no');
  // }
/////////////////////////////////////////
//////////< Shared Preferences >/////////
/////////////////////////////////////////

  static Color basicColor = Color(0xFF56aeff);
  static Color secondColor = Color(0xFF3f3f3f);
  static Color thirdColor = Color(0xFFffffff);
  static String tagLine = "Blippy.io";
  static String planALine =
      "I want to be able to use and test the app if I like it.\nAs new user, I do not want to enter too much personal information at first.";
  static String planBLine =
      "Select this option to join your company. A unique code is required and provided by your company";
  static String planCLine =
      "Owner <Business Account>: A company unique code will be provided upon successful registration in your profile page Get one free employee!";

  static String companies = 'Companies';
  static String userStaff = 'user-staff';
  static String registeredUsers = 'RegisteredUsers';

  static Widget getCheckBoxText(String s) {
    return Text(
      // 'Secret unique will be provided to you after sucessfull registeration.',
      s,
      style: TextStyle(
        fontFamily: "Sofia",
        fontSize: 14,
      ),
    );
  }

  static showAlertDialogBox(BuildContext context, String title, String msg) {
    var alterDialog = AlertDialog(
      title: Text(title),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                msg,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alterDialog;
        });
  }
}
