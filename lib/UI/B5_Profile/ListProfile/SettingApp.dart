import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:total_app/APIs/LoginService.dart';
import '../../../constants.dart';
import 'UploadImage.dart';

class SettingApp extends StatefulWidget {
  final String companycode;
  SettingApp({this.companycode});

  @override
  _SettingApp createState() => _SettingApp();
}

class _SettingApp extends State<SettingApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Constants.basicColor),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Setting(
                head: "Setup your App Account",
                sub1: "Change Password",
                sub2: "Set Business Location",
                sub3: "Main Business Image",
                sub4: "Display Logo",
                sub5: "Business Monthly Theme",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Gotik",
  );

  final String head, sub1, sub2, sub3, sub4, sub5;

  Setting({this.head, this.sub1, this.sub2, this.sub3, this.sub4, this.sub5});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // main header
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  head,
                  style: _txtCustomHead,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),

              //change password
              InkWell(
                onTap: () {
                  var alterDialog = AlertDialog(
                    title: Column(
                      children: [
                        Text('Change Password Securely'),
                        Text('\n${Constants.firebaseAuth.currentUser.email}'),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () async {
                          ////////////////////////////////////////

                          print(Constants.firebaseAuth.currentUser.email);
                          //
                          int res =
                              await AuthenticationService(FirebaseAuth.instance)
                                  .sendPasswordResetEmail(
                                      Constants.firebaseAuth.currentUser.email);
                          if (res == 0) {
                            print('Sent');
                            Navigator.of(context).pop();
                          }
                          ////////////////////////////////////////
                        },
                        child: Text("Send Email"),
                      ),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alterDialog;
                      });

                  ///////////////////////////////////////////////////
                  ///
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub1,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),

              // set my location
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Text('Change my Company Location'),
                              Text('Avaiable for Company'),
                              // Text('\n${Constants.firebaseAuth.currentUser.email}'),
                            ],
                          ),
                          actions: [
                            FlatButton(
                              onPressed: null,
                              child: Text("Change Location from Map"),
                            ),
                          ],
                        );
                      });

                  ///////////////////////////////////////////////////
                  ///
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub2,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),

              // Change main business image
              InkWell(
                onTap: () {
                  ///////////////////////////////////////////////////
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => UploadImage(
                            title: "Change Business Logo",
                          )));
                  ///////////////////////////////////////////////////
                  ///
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub3,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),

              // Change display image
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => UploadImage(
                            title: "Change Display Image",
                            optionWhere: 2,
                          )));
                  ///////////////////////////////////////////////////
                  ///
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub4,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),

              // Change Business Monthly Theme
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => UploadImage(
                            title: "Change Monthly Theme",
                            optionWhere: 2,
                          )));

                  ///////////////////////////////////////////////////
                  ///
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub5,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
