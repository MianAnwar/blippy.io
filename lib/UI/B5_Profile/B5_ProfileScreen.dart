import 'package:flutter/material.dart';
import 'package:total_app/UI/B2_Message/AppBar_ItemScreen/notificationAppbar.dart';
import 'package:total_app/constants.dart';

import 'ListProfile/SettingApp.dart';
import 'ListProfile/License.dart';
import 'package:total_app/UI/IntroApps/SignningOptions.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/editProfile.dart';
import 'package:total_app/UI/IntroApps/Login.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontFamily: "Sofia", fontSize: 25.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //
            //
            // options hi options
            Column(
              children: <Widget>[
                // Account
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new EditProfile()));
                  },
                  child: Category(
                    txt: "Account",
                    image: "assets/image/icon/profile.png",
                    padding: 20.0,
                  ),
                ),

                // Plans
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new SignningOptions()));
                  },
                  child: Category(
                    txt: "Plan",
                    image: "assets/image/icon/box.png",
                    padding: 20.0,
                  ),
                ),

                // Notifications
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new notificationAppbar()));
                  },
                  child: Category(
                    txt: "Notification",
                    image: "assets/image/icon/notification.png",
                    padding: 20.0,
                  ),
                ),

                // // Card
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).push(PageRouteBuilder(
                //         pageBuilder: (_, __, ___) => new addCreditCard()));
                //   },
                //   child: category(
                //     txt: "Card erase ",
                //     image: "assets/image/icon/card.png",
                //     padding: 20.0,
                //   ),
                // ),

                //Settings
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new SettingApp()));
                  },
                  child: Category(
                    txt: "App Settings",
                    image: "assets/image/icon/settings.png",
                    padding: 20.0,
                  ),
                ),

                // About
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LicensesSimplePage()));
                  },
                  child: Category(
                    txt: "About",
                    image: "assets/image/icon/italia.png",
                    padding: 20.0,
                  ),
                ),

                // Logout Button
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      var alterDialog = AlertDialog(
                        title: Text('Alert'),
                        content: Text('Are you sure to logout?'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new Login(),
                                  transitionDuration: Duration(milliseconds: 0),
                                  transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                    return Opacity(
                                      opacity: animation.value,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text("Yes"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alterDialog;
                          });
                    },
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      color: Constants.basicColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 13.0, left: 20.0, bottom: 15.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Constants.thirdColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Gotik",
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  String txt, image;
  GestureTapCallback tap;
  double padding;

  Category({this.txt, this.image, this.tap, this.padding});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Image.asset(
                        image,
                        height: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
