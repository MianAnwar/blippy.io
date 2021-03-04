import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/User.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:total_app/DataModels/BusinessModel.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class PlanCSignup extends StatefulWidget {
  @override
  _PlanCSignupState createState() => _PlanCSignupState();
}

class _PlanCSignupState extends State<PlanCSignup>
    with TickerProviderStateMixin {
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  var _signupformKey = GlobalKey<FormState>();
  TextEditingController fullnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();

  TextEditingController businessNameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();

  bool agree1 = false, agree2 = false, agree3 = false;
  bool showPwd = false;
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  //Animation Declaration

  /// set state  controller
  @override
  void initState() {
    // TOD implement initState
    super.initState();
  }

  /// Dispose controller
  @override
  void dispose() {
    super.dispose();
  }

  _launchInBrowser(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(
    //     url,
    //     forceSafariVC: false,
    //     forceWebView: false,
    //     headers: <String, String>{'my_header_key': 'my_header_value'},
    //   );
    // } else {
    //   print('Could not launch $url');
    //   // throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: Constants.thirdColor),
        ),
        backgroundColor: Constants.basicColor,
        centerTitle: true,
        title: Text(
          "New Business",
          style: TextStyle(
              color: Constants.thirdColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Constants.thirdColor,
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              //
              ////// From Top to SignIn
              Column(
                children: <Widget>[
                  /////////////////////////////////////////////////
                  ////////////////  Sign In Form /////////////////
                  /////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    //////
                    ////////////
                    //////////////////
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        /// Fade Animation for transtition animaniton
                        // FadeAnimation(
                        //   0,
                        //   Center(
                        //     child: Text(
                        //       "Register your\nCompany/Store",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //           color: Constants.secondColor,
                        //           fontFamily: "Sofia",
                        //           fontWeight: FontWeight.w800,
                        //           fontSize:
                        //               MediaQuery.of(context).size.width * 0.1,
                        //           wordSpacing: 0.1),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.04),
                        FadeAnimation(
                          1.7,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Form(
                              key: _signupformKey,
                              child: Column(
                                children: <Widget>[
                                  Divider(),
                                  Text(
                                    'Owner Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Gotik",
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),

                                  //Username
                                  Container(
                                    padding:
                                        EdgeInsets.all(10).copyWith(top: 3),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: fullnameCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Full Name",
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  //Email
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: emailCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  //Password
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        // color: Colors.red,
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: pwdCtrl,
                                          validator: (s) {
                                            if (s.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                          obscureText: showPwd,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            icon: Icon(Icons.vpn_key,
                                                color: Colors.black12),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: "sofia"),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(!showPwd
                                            ? Icons.remove_red_eye
                                            : Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            showPwd = !showPwd;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          pwdCtrl.text = '';
                                        },
                                      ),
                                    ],
                                  ),

                                  ////////////////////////////////
                                  ///
                                  Divider(),
                                  Text(
                                    'Business Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Gotik",
                                    ),
                                  ),
                                  Divider(),

                                  //Business Name
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: businessNameCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Business Name",
                                        icon: Icon(Icons.business,
                                            color: Colors.black12),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  //Address
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: addressCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Address",
                                        icon: Icon(
                                          Icons.location_city_outlined,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  //Contact No
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: contactCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Contact#",
                                        icon: Icon(
                                          Icons.phone,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  Divider(),
                                  ListTile(
                                    // onTap: () {
                                    //   setState(() {
                                    //     this.agree1 = !this.agree1;
                                    //   });
                                    // },
                                    leading: Checkbox(
                                      value: this.agree1,
                                      onChanged: (v) {
                                        setState(() {
                                          this.agree1 = v;
                                        });
                                      },
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                              text:
                                                  'By creating an account, you are agreeing to Blippy ',
                                              style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 14,
                                              ),
                                              children: []),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _launchInBrowser(
                                                'https://www.blippy.io/terms-conditions');
                                          },
                                          child: Text.rich(
                                            TextSpan(
                                                text: 'terms & conditions ',
                                                style: TextStyle(
                                                  fontFamily: "Sofia",
                                                  fontSize: 14,
                                                  color: Constants.basicColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: ' and Blippy ',
                                                    style: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'privacy policy. ',
                                            style: TextStyle(
                                              fontFamily: "Sofia",
                                              fontSize: 14,
                                              color: Constants.basicColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      setState(() {
                                        this.agree2 = !this.agree2;
                                      });
                                    },
                                    leading: Checkbox(
                                      value: this.agree2,
                                      onChanged: (v) {
                                        setState(() {
                                          this.agree2 = v;
                                        });
                                      },
                                    ),
                                    title: Constants.getCheckBoxText(
                                        'Get free Staff Count upto 1 upon registeration.'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      setState(() {
                                        this.agree3 = !this.agree3;
                                      });
                                    },
                                    leading: Checkbox(
                                      value: this.agree3,
                                      onChanged: (v) {
                                        setState(() {
                                          this.agree3 = v;
                                        });
                                      },
                                    ),
                                    title: Constants.getCheckBoxText(
                                        'Secret unique will be provided to you after sucessfull registeration.'),
                                  ),

                                  Divider(),

                                  ///
                                  ////////////////////////////////
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////////////////////
                  //////////////// Sign up Button /////////////////
                  /////////////////////////////////////////////////

                  InkWell(
                    splashColor: Constants.secondColor,
                    onTap: () async {
                      /////
                      ///
                      if (!this.agree1 || !this.agree2 || !this.agree3) {
                        Constants.showAlertDialogBox(
                            context, 'Alert', 'Select the options');
                        return -1;
                      }
                      if (this._signupformKey.currentState.validate()) {
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.style(message: 'Please Wait...');
                        await dialog.show();
                        //
                        /////// Get the credentials and verify them from database,
                        ///////     after verification take use to dashboard

                        String fullName = fullnameCtrl.text;
                        String email = emailCtrl.text;
                        String password = pwdCtrl.text;
                        String cntactNo = contactCtrl.text;

                        Profile profile = Profile(
                          '',
                          fullName,
                          email,
                          Role.Owner.toString(),
                          cntactNo,
                          retToken: -1,
                        );

                        profile =
                            await AuthenticationService(FirebaseAuth.instance)
                                .createBussinessAccount(
                          profile: profile,
                          pass: password,
                        );

                        if (profile.retToken == 0) {
                          // sucessfully account created
                          String businessName = businessNameCtrl.text;
                          String contact = contactCtrl.text;
                          String address = addressCtrl.text;

                          Business business = Business(
                            secretCode: profile.companycode, //Sercet code
                            businessName: businessName,
                            email: profile.email,
                            imageURL: '', // image url
                            contactNo: contact,
                            address: address,
                            locationLat: 0.0,
                            locationLog: 0.0,
                            productCount: 0,
                            staffCount: 0,
                          );

                          // now insert into Companies(business) and Users-Staff
                          int x = AuthenticationService.registerNewCompany(
                              profile, business);
                          await dialog.hide();
                          if (x == 1) {
                            Constants.showAlertDialogBox(context, 'Alert',
                                'Verification Email Sent. Sucessfully Company/Store Registered. Setup more important fields after signin.');
                            fullnameCtrl.clear();
                            pwdCtrl.clear();
                            addressCtrl.clear();
                            contactCtrl.clear();
                            setState(() {
                              agree1 = false;
                              agree2 = false;
                              agree3 = false;
                            });
                          } else if (x == -1) {
                            Constants.showAlertDialogBox(context, 'Alert',
                                'Could not complete the process.');
                          }
                        }
                        ///////// retToken other than 0 Means there is some problem.
                        else {
                          await dialog.hide();
                          Constants.showAlertDialogBox(
                            context,
                            'Alert',
                            profile.retToken == 1
                                ? 'weak-password'
                                : profile.retToken == 2
                                    ? 'email-already-in-use'
                                    : profile.retToken == 3
                                        ? 'invalid-email'
                                        : profile.retToken == 4
                                            ? 'operation-not-allowed'
                                            : 'There is some problem. Try Again.',
                          );
                          return -1;
                        }
                        ///////////////////////////////////////////////
                        ///////////////////////////////////////////////
                      } else {
                        print('Empty Field(s)');
                      }
                    },
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.basicColor,
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
              ////// From Top to SignIn
              ///
            ],
          ),
        ],
      ),
    );
  }
}
