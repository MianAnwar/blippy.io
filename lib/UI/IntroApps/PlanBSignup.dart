import 'package:firebase_auth/firebase_auth.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/User.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class PlanBSignup extends StatefulWidget {
  final String companyCode;

  PlanBSignup({this.companyCode});
  @override
  _PlanBSignupState createState() => _PlanBSignupState();
}

class _PlanBSignupState extends State<PlanBSignup>
    with TickerProviderStateMixin {
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  var _signupformKey = GlobalKey<FormState>();
  TextEditingController fullnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();

  TextEditingController ckeyCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();

  var desg = ['Role.DesignatedStaff', 'Role.RegularStaff'];
  var designation = 'Role.RegularStaff';

  TextEditingController contactCtrl = TextEditingController();
//
  bool agree1 = false, agree2 = false;
  bool showPwd = false;
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  /// set state controller
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
          "Join Business",
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
                        //       "Hire Staff \nto manage \nCompany/Store",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //           color: Constants.secondColor,
                        //           fontFamily: "Sofia",
                        //           fontWeight: FontWeight.w800,
                        //           fontSize:
                        //               MediaQuery.of(context).size.width * 0.08,
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
                                    'Staff Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Gotik",
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),

                                  //Username
                                  Container(
                                    padding: EdgeInsets.all(10),
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
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
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
                                  Divider(),

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
                                          return "Must Fill the Field";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
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

                                  ////////////////////////////////
                                  ///
                                  Divider(),
                                  Text(
                                    'Company Related Info',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Gotik",
                                    ),
                                  ),
                                  Divider(),

                                  //Company Code
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      // obscureText: true,
                                      controller: ckeyCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Must Fill the Field";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Company Code",
                                        icon: Icon(
                                          Icons.https_outlined,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia"),
                                      ),
                                    ),
                                  ),

                                  //Designation
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.event_seat_rounded,
                                          color: Colors.black12,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: DropdownButton<String>(
                                            value: this.designation,
                                            onChanged:
                                                (String newSelectedItem) {
                                              setState(() {
                                                this.designation =
                                                    newSelectedItem;
                                              });
                                            },
                                            items: desg.map(
                                              (String item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 20.0),
                                                    child: Text(item,
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontFamily:
                                                                "sofia")),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(),
                                  ListTile(
                                    onTap: () {
                                      setState(() {
                                        this.agree1 = !this.agree1;
                                      });
                                    },
                                    leading: Checkbox(
                                      value: this.agree1,
                                      onChanged: (v) {
                                        setState(() {
                                          this.agree1 = v;
                                        });
                                      },
                                    ),
                                    title: Constants.getCheckBoxText(
                                        'I agree, all the terms and condition. Total Blippy.io is sovereinty to us.'),
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
                                        'Pay a fixed amount for hiring more than 1 staff.'),
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
                  /////////////////////////////////////////////////
                  //////////////// Sign up Button /////////////////
                  /////////////////////////////////////////////////
                  //////////////////< Hiring >/////////////////////
                  /////////////////////////////////////////////////

                  InkWell(
                    splashColor: Constants.secondColor,
                    onTap: () async {
                      /////
                      ///
                      if (!this.agree1 || !this.agree2) {
                        Constants.showAlertDialogBox(
                            context, 'Alert', 'Select the options');
                        return -1;
                      }
                      if (this._signupformKey.currentState.validate()) {
                        //
                        String fullName = fullnameCtrl.text;
                        String email = emailCtrl.text;
                        String cntactNo = contactCtrl.text;
                        String cc = ckeyCtrl.text;
                        String designation = this.designation;

                        Profile profile = Profile(
                          cc,
                          fullName,
                          email,
                          designation,
                          cntactNo,
                          retToken: -1,
                        );
                        // print(cc);
                        //verify company code
                        int exists =
                            await AuthenticationService.verifyCompanyCode(cc);

                        // print('------');
                        // print(cc);
                        if (exists == 1) {
                          Constants.showAlertDialogBox(
                              context, 'Alert', 'Company code is not valid.');
                          return -1;
                        } else if (exists == -1) {
                          Constants.showAlertDialogBox(context, 'Alert',
                              'There is some problem with system.1');
                          return -1;
                        } else if (exists == 0) {
                          //continue
                          print('continue.............................');
                          int countOfStaff =
                              await AuthenticationService.getCountofStaff(cc);

                          print(
                              '$countOfStaff, ${countOfStaff + 1} continue.............................');

                          if (countOfStaff == -1) {
                            Constants.showAlertDialogBox(context, 'Alert',
                                'There is some problem with system.2');
                            return -1;
                          } else if (countOfStaff == -2) {
                            Constants.showAlertDialogBox(
                                context, 'Alert', 'company is no more.');
                            return -1;
                          } else if (countOfStaff == 0) {
                            //hire first staff
                            //
                            return 1;
                          } else {
                            // you need to pay
                            // then you can hire more staff
                            Constants.showAlertDialogBox(context, 'Alert',
                                'pAY 10 eUROs to hire more staff.');
                          }
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
                          BUser usr =
                              await AuthenticationService(FirebaseAuth.instance)
                                  .signUp(
                                      email: emailCtrl.text,
                                      password: pwdCtrl.text,
                                      userName: fullnameCtrl.text);

                          if (usr.retToken == 0) {
                            // sucessfully account created
                            int x =
                                AuthenticationService.saveStaffUser(profile);
                            if (x == 1) {
                              Constants.showAlertDialogBox(context, 'Alert',
                                  ' You successfully Hire a new Staff Memeber. Verification Email sent.');
                            } else {
                              Constants.showAlertDialogBox(context, 'Alert',
                                  'There is some problem occured. Contact Admin for more details.');
                            }
                          }
                          ///////// retToken other than 0 Means there is some problem.
                          else {
                            Constants.showAlertDialogBox(
                              context,
                              'Alert',
                              usr.retToken == 1
                                  ? 'weak-password'
                                  : usr.retToken == 2
                                      ? 'email-already-in-use'
                                      : usr.retToken == 3
                                          ? 'invalid-email'
                                          : usr.retToken == 4
                                              ? 'operation-not-allowed'
                                              : 'There is some problem. Try Again.',
                            );
                            return -1;
                          }
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

                        }
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
