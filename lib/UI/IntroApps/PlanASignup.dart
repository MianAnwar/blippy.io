import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/User.dart';

class PlanASignup extends StatefulWidget {
  @override
  _PlanASignupState createState() => _PlanASignupState();
}

class _PlanASignupState extends State<PlanASignup>
    with TickerProviderStateMixin {
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  var _signupformKey = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();

  bool showPwd = true;
// backend miananwar.2244@gmail.com
// backend miananwar.2244@gmail.com

  /// set state  controller
  @override
  void initState() {
    //
    // TOD implement initState
    super.initState();
  }

  /// Dispose
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
          "Test User",
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
                        FadeAnimation(
                          0,
                          Center(
                            child: Text(
                              "As a Test User\nSign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Constants.secondColor,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w800,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.07,
                                  wordSpacing: 0.1),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
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
                                  //Username
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      controller: usernameCtrl,
                                      validator: (s) {
                                        if (s.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
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
                  //////////////// Sign up Button /////////////////
                  /////////////////////////////////////////////////

                  InkWell(
                    splashColor: Constants.secondColor,
                    onTap: () async {
                      /////
                      ///
                      if (this._signupformKey.currentState.validate()) {
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.style(message: 'Please Wait...');
                        await dialog.show();
                        //
                        /////// Get the credentials and verify them from database,
                        ///////     after verification take use to dashboard

                        String uname = usernameCtrl.text;
                        String email = emailCtrl.text;
                        String password = pwdCtrl.text;

                        BUser result =
                            await AuthenticationService(FirebaseAuth.instance)
                                .signUp(
                                    email: email,
                                    password: password,
                                    userName: uname);
                        print('checking....1');
                        if (result.retToken == 0) {
                          // now insert into Test User
                          int x = AuthenticationService.saveTestUser(result);
                          await dialog.hide();

                          if (x == 1) {
                            Constants.showAlertDialogBox(
                                context, 'Alert', 'Verification Email Sent.');
                          } else if (x == -1) {
                            Constants.showAlertDialogBox(context, 'Alert',
                                'Could not complete the process.');
                          }
                          usernameCtrl.clear();
                          pwdCtrl.clear();
                        } else {
                          await dialog.hide();
                          Constants.showAlertDialogBox(
                            context,
                            'Alert',
                            result.retToken == 1
                                ? 'weak-password'
                                : result.retToken == 2
                                    ? 'email-already-in-use'
                                    : result.retToken == 3
                                        ? 'invalid-email'
                                        : result.retToken == 4
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
