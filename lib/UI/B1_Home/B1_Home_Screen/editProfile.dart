import 'package:flutter/material.dart';
import 'package:total_app/APIs/APIService.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/SettingApp.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class EditProfile extends StatefulWidget {
  Profile profile;

  EditProfile({Key key, this.profile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String newUsername, oldusername;
  String newPhoneNumber, oldPhoneNumber;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();

  @override
  void initState() {
    // TO: implement
    super.initState();
    usernameCtrl.text = widget.profile.fullname;
    userPhoneNumber.text = widget.profile.contactNo;
  }

  updateUsername() async {
    int x = await APIServices.updateRegisteredUserName(
        newUsername, widget.profile.email);
    return x;
  }

  updatePhoneNumber() async {
    int x = await APIServices.updateRegisteredPhoneNumber(
        newPhoneNumber, widget.profile.email);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    this.oldusername = widget.profile.fullname ?? 'Registered User';
    this.oldPhoneNumber = widget.profile.contactNo ?? 'Registered User';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Account",
            style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () async {
                newPhoneNumber = userPhoneNumber.text;
                newUsername = usernameCtrl.text;

                if (userPhoneNumber.text == '') {
                  Constants.showAlertDialogBox(
                      context, 'Alert', 'Must Enter Contact No.');
                } else {
                  if (oldPhoneNumber == newPhoneNumber) {
                    // Navigator.pop(context); // Contact Number
                  } else {
                    int x = await updatePhoneNumber();
                    if (x == 0) {
                      // Navigator.pop(context);
                    } else {
                      Constants.showAlertDialogBox(context, 'Problem',
                          'There is a problem with your record in our system. Try Again.');
                    }
                  }
                  // Update username for the respective email.

                  /////
                }

                if (usernameCtrl.text == '') {
                  Constants.showAlertDialogBox(
                      context, 'Alert', 'Must Enter UserName.');
                } else {
                  if (oldusername == newUsername) {
                    // Navigator.pop(context);
                  } else {
                    int x = await updateUsername();
                    if (x == 0) {
                      // Navigator.pop(context);
                    } else {
                      Constants.showAlertDialogBox(context, 'Problem',
                          'There is a problem with your record in our system. Try Again.');
                    }
                  }
                  // Update username for the respective email.
                  Navigator.pop(context);

                  /////
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Save",
                    style: TextStyle(
                      color: Color(0xFF56aeff),
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w800,
                      fontSize: 17.0,
                    )),
              ),
            ),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Container(
                        height: 430.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                              spreadRadius: 10.0,
                              color: Colors.black12.withOpacity(0.03),
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50.0),

                            //Username
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 50.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // username field
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 13.0),
                                        child: TextFormField(
                                            controller: usernameCtrl,
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17.0),
                                            decoration: InputDecoration(
                                              hintText: "Enter Username",
                                              hintStyle: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 17.0),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),

                            //Email
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 45.0),
                                      child: TextFormField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: '${widget.profile.email}',
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0),
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                  style: BorderStyle.none),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),

                            //Contact Number
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Contact#",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: TextFormField(
                                          controller: userPhoneNumber,
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Contact Number',
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17.0),
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                  style: BorderStyle.none),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),

                            //Address
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Role",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: TextFormField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: '${widget.profile.role}',
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17.0),
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                  style: BorderStyle.none),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 1.3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // impage
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SettingApp(),
                            transitionDuration: Duration(milliseconds: 1000),
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'hero-tag-profile',
                        child: Container(
                          height: 130.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              image: DecorationImage(
                                  image: widget.profile.dpimageURL == ''
                                      ? AssetImage(
                                          "assets/image/icon/profile.png")
                                      : NetworkImage(widget.profile.dpimageURL),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
