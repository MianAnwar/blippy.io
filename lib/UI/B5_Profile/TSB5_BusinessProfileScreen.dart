import 'package:flutter/material.dart';
import 'package:total_app/UI/B4_Review/TStaffs.dart';
import 'package:total_app/APIs/APIService.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/TSeditProfile.dart';
import 'package:total_app/constants.dart';

import 'ListProfile/TSSettingApp.dart';
import 'package:total_app/UI/IntroApps/PlanBSignup.dart';

class TSBusinessProfileScreen extends StatefulWidget {
  final String email;
  TSBusinessProfileScreen({Key key, this.email}) : super(key: key);

  @override
  _TSBusinessProfileScreenState createState() =>
      _TSBusinessProfileScreenState();
}

class _TSBusinessProfileScreenState extends State<TSBusinessProfileScreen> {
  String username;

  @override
  void initState() {
    // TO: implement initState
    setUSername();
    super.initState();
  }

  setUSername() async {
    this.username = await APIServices.getTestUserName(widget.email);
    setState(() {});
  }

  Widget buildItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13),
      // color: Colors.amber,
      child: Column(
        children: [
          // Expanded(
          //   // flex: 1,
          //   child:
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  tag: 'hero-tag-profile',
                  child: Image(
                    width: 150,
                    height: 150,
                    image: AssetImage(
                      'assets/image/icon/profile.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            // ),
          ),
          // Expanded(
          // flex: 2,
          // child:
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.all(5.0),
            onPressed: () {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new TSEditProfile(
                        email: widget.email,
                      )));
            },
            color: Colors.white,
            child: Text("view And Edit Profile"),
          ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.of(context).push(PageRouteBuilder(
          //           pageBuilder: (_, __, ___) =>
          //               new TSViewEditProfile(email: widget.email)));
          //     },
          //     child: Padding(
          //       padding: EdgeInsets.only(left: 10.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "${username ?? 'Test User'}",
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 17,
          //             ),
          //           ),
          //           SizedBox(height: 8),
          //           Container(
          //             padding: EdgeInsets.all(8),
          //             color: Colors.grey[300],
          //             child: Text("View and Edit Profile"),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Business Settings",
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
                buildItem(),
                SizedBox(
                  height: 20,
                ),
                // Plans
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new PlanBSignup()));
                  },
                  child: Category(
                    txt: "Hire Staff",
                    image: "assets/image/icon/box.png",
                    padding: 20.0,
                  ),
                ),

                // Notifications
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new StaffsScreen()));
                  },
                  child: Category(
                    txt: "List of Staff",
                    image: "assets/image/icon/notification.png",
                    padding: 20.0,
                  ),
                ),

                //Settings
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new TSAppSetting()));
                  },
                  child: Category(
                    txt: "Change Store Location",
                    image: "assets/image/icon/settings.png",
                    padding: 20.0,
                  ),
                ),

                // About
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => new LicensesSimplePage()));
                    Constants.showAlertDialogBox(
                        context, 'Copy Company Code', 'You are in test mode.');
                  },
                  child: Category(
                    txt: "View Secret Company Code",
                    image: "assets/image/icon/italia.png",
                    padding: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteAccount(String email, String pwd) async {
    bool res = await APIServices.deleteAccount(email, pwd);
    return res;
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

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
