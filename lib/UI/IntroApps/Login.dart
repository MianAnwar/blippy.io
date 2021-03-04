import 'package:firebase_auth/firebase_auth.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/TSLoginAnimation.dart';
import 'package:total_app/constants.dart';
import 'SignningOptions.dart';
import 'ForgetPassword.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  var _signInformKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  Profile _profile;
  String emailTS;
  bool showPwd = true;
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  //Animation Declaration
  AnimationController sanimationController;
  var tap = 0;

  /// set state animation controller
  @override
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TOD implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _playAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // top picture
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: Constants.thirdColor,
                    child: FadeAnimation(
                      0.2,
                      Container(
                        child: Center(
                          child: Hero(
                            tag: 'iconImage',
                            child: Image.asset(
                              'assets/logos.png',
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Fade Animation for transtition animaniton
                        FadeAnimation(
                          0,
                          Center(
                            child: Text(
                              // "Sign In",
                              "",
                              style: TextStyle(
                                  color: Constants.secondColor,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w800,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.1,
                                  wordSpacing: 0.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
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
                              key: _signInformKey,
                              child: Column(
                                children: <Widget>[
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
                                  )
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
                  //////////////// Sign In Button /////////////////
                  /////////////////////////////////////////////////
                  tap == 0
                      ? InkWell(
                          splashColor: Constants.secondColor,
                          onTap: () async {
                            if (this._signInformKey.currentState.validate()) {
                              ////////////////////////////////////
                              ProgressDialog dialog = ProgressDialog(context);
                              dialog.style(message: 'Please Wait...');
                              await dialog.show();
                              /////////////////////////////////////

                              /////// Get the credentials and verify them from database,
                              ///////     after verification take use to dashboard

                              String email = emailCtrl.text;
                              emailTS = email;
                              String password = pwdCtrl.text;

                              // Get ready
                              AuthenticationService service =
                                  AuthenticationService(Constants.firebaseAuth);

                              // get result if sucessfull or not
                              int result = await service.signIn(
                                  email: email, password: password);

                              // check even for varified
                              if (result == 0) {
                                // successfull :: YES, verified
                                bool testUser = await AuthenticationService
                                    .checkEmailInTestUsers(email);
                                await dialog.hide();
                                ////////
                                ////////
                                ////////
                                if (testUser) {
                                  // Save the email in sharedPref
                                  Constants.setEmail(email);

                                  // proceed towards Tester Dashboard
                                  //    :::::with ::::::: email,0
                                  setState(() {
                                    tap = 2;
                                    new TSLoginAnimation(
                                      animationController:
                                          sanimationController.view,
                                      email: emailTS,
                                    );
                                    _playAnimation();
                                    return tap;
                                    //////////////////////////////////////////////////////
                                  });
                                  ///////
                                  ////////

                                } else {
                                  // proceed towards checking other Deshboard
                                  Profile p = await AuthenticationService
                                      .checkEmailinRegisteredUsers(email);
                                  if (p != null) {
                                    if (p.role != 'Role.Owner' &&
                                        p.role != 'Role.DesignatedStaff' &&
                                        p.role != 'Role.RegularStaff') {
                                      // Error// No Correct Designation
                                    } else {
                                      Constants.setEmail(email);
                                      this._profile = p;

                                      if (p.role == 'Role.RegularStaff') {
                                        // Navigate to regular staff dashboard
                                        setState(() {
                                          tap = 1; ////
                                          new LoginAnimation(
                                            //^^^^^^^^^^^^^
                                            animationController:
                                                sanimationController.view,
                                            profile: p,
                                          );
                                          _playAnimation();
                                          return tap;
                                          //////////////////////////////////////////////////////
                                        });
                                      } else {
                                        // NAvigate to owner dashboard
                                        setState(() {
                                          tap = 1;
                                          new LoginAnimation(
                                            animationController:
                                                sanimationController.view,
                                            profile: p,
                                          );
                                          _playAnimation();
                                          return tap;
                                          //////////////////////////////////////////////////////
                                        });
                                      }
                                      ///////
                                      //proceed to dashboard for respective owner, staff, D.staff
                                      ///////////////////////////////////////////////
                                      ///////////////////////////////////////////////

                                    }
                                  } else {
                                    // proceed to setup profile
                                    // user have credentials but not setup his profile.
                                  }
                                }
                              } else {
                                await dialog.hide();
                                ////////////////////////////////////////////////////
                                Constants.showAlertDialogBox(
                                    context,
                                    'Alert',
                                    result == -1
                                        ? 'Email is not verified. Please verify it first.'
                                        : result == 1
                                            ? 'user-not-found'
                                            : result == 2
                                                ? 'wrong-password'
                                                : 'There is some problem. Try Again.');
                                return -1;
                              }
                            } else {
                              // print('object111111');
                            }
                          },
                          child: FadeAnimation(
                            1.9,
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 55,
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.basicColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : tap == 1 // login with (email, 1) for Owner/Staff,
                          ? new LoginAnimation(
                              animationController: sanimationController.view,
                              profile: this._profile,
                            )
                          : new TSLoginAnimation(
                              // login with (email, 2) for TestUser
                              animationController: sanimationController.view,
                              email: emailTS,
                            ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  //////// Forget Password ////////
                  FadeAnimation(
                    1.7,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => ForgetPassword(),
                            transitionDuration: Duration(milliseconds: 700),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Constants.secondColor, //Colors.black38,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),

                  FadeAnimation(
                    1.7,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SignningOptions(),
                            transitionDuration: Duration(milliseconds: 750),
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
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Create New Account",
                            style: TextStyle(
                                color: Constants.secondColor, //Colors.black38,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 1.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
