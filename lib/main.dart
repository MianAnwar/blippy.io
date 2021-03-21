import 'dart:async';
import 'package:flutter/material.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:total_app/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:total_app/UI/IntroApps/Login.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'DataModels/ProfileModel.dart';
import 'UI/Bottom_Nav_Bar/TSbottomNavBar.dart';
import 'UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Constants.initailizeSP();
  // run the App
  runApp(Splash());
}

class Splash extends StatelessWidget {
// Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "There is some Error, Restart your app, Check your Internet Connection etc. \nTry Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
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

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              primaryColorLight: Colors.white,
              primaryColorBrightness: Brightness.light,
              // primaryColor: Colors.white,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColorLight: Colors.white,
            primaryColorBrightness: Brightness.light,
            primaryColor: Colors.white,
          ),
        );
      },
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
  _navigator() async {
    //
// first of all check user email from shared preferences
// if yes, then proceed further otherwise navigate to login

////////////////////////////////////////////////////
    String email = Constants.getEmail() ?? '';
////////////////////////////////////////////////////

    if (email == '') {
      // NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO in sharedPreferences
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => new Login(),
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
        ),
      );
    } else {
      // YES YES YES YES YES YES YES YES YES YES YES YES in sharedPreferences
      bool testUser = await AuthenticationService.checkEmailInTestUsers(email);

      if (testUser) {
        // proceed towards Tester Dashboard
        //    :::::with ::::::: email
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                new TSBtmNavBar(email: email), //////////
            transitionDuration: Duration(milliseconds: 2600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
        ////////////////////////
      } else {
        // proceed towards checking other Deshboard
        Profile p =
            await AuthenticationService.checkEmailinRegisteredUsers(email);
        if (p != null) {
          if (p.role != 'Role.Owner' &&
              p.role != 'Role.DesignatedStaff' &&
              p.role != 'Role.RegularStaff') {
            // Error// No Correct Designation
            // Somehow your data is tempered due to some reason, contact System Developer
          } else {
            //proceed to dashboard for respective owner, staff, D.staff/Owner
            if (p.role == 'Role.RegularStaff') {
              // Navigate to regular staff dashboard
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      /*change it */ BottomNavBar(profile: p), ///// change it
                  transitionDuration: Duration(milliseconds: 2000),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  },
                ),
              );
            } else {
              // NAvigate to owner dashboard
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      new BottomNavBar(profile: p), //////////
                  transitionDuration: Duration(milliseconds: 2600),
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
          }
        } else {
          // proceed to setup profile
          // not in testUsers and also not in RegisteredUsers
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => new Login(),
              transitionDuration: Duration(milliseconds: 2000),
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
      }
    }

    ///
    ///
    ///
    /////////////////////////////////////////
  }

  /// Set timer Splash
  _timer() async {
    // return Timer(Duration(milliseconds: 3300), _navigator);
    return await _navigator();
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 10), _timer);
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
                  // 'assets/Image/illustration/empty.png',
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
