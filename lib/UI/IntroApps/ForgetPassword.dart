import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
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
          child: Icon(
            Icons.arrow_back,
            color: Constants.secondColor,
          ),
        ),
        backgroundColor: Constants.basicColor,
        centerTitle: true,
        title: Text(
          "Password Reset",
          style: TextStyle(
            color: Constants.secondColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          buildForgetPasswordCard(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }

  Widget buildForgetPasswordCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Enter the email address associated with your Teams account. ", //
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.secondColor, //Colors.black38,
                fontFamily: "profile",
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            subtitle: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Registered Email",
                  icon: Icon(
                    Icons.email,
                    color: Colors.black12,
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: "sofia"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          InkWell(
            splashColor: Constants.secondColor,
            onTap: () {
              // call some function for further management with 1, 2 ,3
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
                  "Recover Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      letterSpacing: 1.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
