import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

Future main() async {
  // set up DeviceOrientation
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // run the App
  runApp(MyApp());
}

///////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Constants.basicColor),
      home: SplashScreen1(),
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    // TODo implement initState
    var d = Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SplashScreen2();
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: Center(
          child: Hero(
            tag: 'iconImage',
            child: Image.asset(
              "assets/icon.png",
            ),
          ),
        ),
      ),
    );
  }
}

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: Hero(
          tag: 'iconImage',
          child: Image.asset(
            "assets/icon1.png",
          ),
        ),
      ),
    );
  }
}
