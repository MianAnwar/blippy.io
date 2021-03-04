import 'package:flutter/material.dart';

class StaffsScreen extends StatefulWidget {
  StaffsScreen({Key key}) : super(key: key);

  @override
  _StaffsScreenState createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Staff",
          style: TextStyle(
            fontFamily: "Sofia",
            fontWeight: FontWeight.w800,
            wordSpacing: 0.1,
          ),
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title + Icon,     Products for Review
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
              child: Text("My Current Staff handle"),
            ),

            buildStaff(),
            Divider(),
            buildStaff(),
            Divider(),
            buildStaff(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildStaff() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13),
      // color: Colors.amber,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    width: 80,
                    height: 80,
                    image: AssetImage(
                      'assets/image/icon/profile.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Demohan Milke",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Email: demohan@gmail.com",
                    maxLines: 5,
                  ),
                  Text(
                    "Contact: +104-22332142234",
                    maxLines: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
