import 'package:flutter/material.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/constants.dart';
import 'PlanASignup.dart';
import 'PlanBSignup.dart';
import 'PlanCSignup.dart';

class SignningOptions extends StatefulWidget {
  @override
  _SignningOptionsState createState() => _SignningOptionsState();
}

class _SignningOptionsState extends State<SignningOptions>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  // var tap = 0;

  /// set state animation controller
  @override
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.thirdColor,
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
          "PLAN OPTIONS",
          style: TextStyle(
              color: Constants.thirdColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          buildPlanCard("Test User", Constants.planALine, 1),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          buildPlanCard("Join an existing business", Constants.planBLine, 2),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          buildPlanCard("New Business", Constants.planCLine, 3),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }

  Widget buildPlanCard(String name, String description, int i) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              name, //
              style: TextStyle(
                color: Constants.secondColor, //Colors.black38,
                fontFamily: "profile",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            subtitle: Text(description), //
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          InkWell(
            splashColor: Constants.secondColor,
            onTap: () {
              // call some function for further management with 1, 2 ,3
            },
            child: FadeAnimation(
              0.1,
              InkWell(
                onTap: () {
                  if (i == 1) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => PlanASignup(),
                        transitionDuration: Duration(milliseconds: 700),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        },
                      ),
                    );
                  } else if (i == 2) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => PlanBSignup(),
                        transitionDuration: Duration(milliseconds: 700),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        },
                      ),
                    );
                  } else if (i == 3) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => PlanCSignup(),
                        transitionDuration: Duration(milliseconds: 700),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Container(
                  height: 48,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
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
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
