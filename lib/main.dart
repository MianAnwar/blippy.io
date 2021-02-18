import 'dart:async';
import 'package:flutter/material.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/UI/IntroApps/Login.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColorBrightness: Brightness.light,
        primaryColor: Colors.white,
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//////////////////////<  Splash Screens  >/////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  //
  // to navigator to other screens
  void _navigator() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => new Login(),
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  /// Set timer Splash
  _timer() async {
    return Timer(Duration(milliseconds: 3300), _navigator);
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.basicColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(
            2.0,
            Center(
              child: Hero(
                tag: 'iconImage',
                child: Image.asset(
                  'assets/logos.png',
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
