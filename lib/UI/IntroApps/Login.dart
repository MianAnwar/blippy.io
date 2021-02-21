import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:total_app/constants.dart';
import 'SignningOptions.dart';
import 'ForgetPassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
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
                    height: MediaQuery.of(context).size.height * 0.33,
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
                      top: 10,
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
                              "Sign In",
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
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Username",
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
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      icon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.black12,
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "sofia"),
                                    ),
                                  ),
                                )
                              ],
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
                          onTap: () {
                            setState(() {
                              /////
                              /////// Get the credentials and verify them from database,
                              ///////     after verification take use to dashboard
                              ///// if not verified then return 'foran' with -1
                              tap = 1;
                            });
                            new LoginAnimation(
                              animationController: sanimationController.view,
                            );
                            _playAnimation();
                            return tap;
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
                      : new LoginAnimation(
                          animationController: sanimationController.view,
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
                              "Forget Password?",
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),

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
                          top: MediaQuery.of(context).size.height * 0.04,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Sign Up",
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
