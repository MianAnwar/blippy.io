import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:total_app/constants.dart';

class Scanning extends StatefulWidget {
  Scanning({Key key}) : super(key: key);

  @override
  _ScanningState createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Scan",
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
              fontSize: 29.5,
              wordSpacing: 0.1),
        ),
      ),

      // body
      body: Stack(
        children: <Widget>[
          // background Image: covers all the screen
          Image.asset(
            "assets/image/destinationPopuler/destination1.png",
            height: _height,
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 210,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.black12.withOpacity(0.08),
                    )
                  ],
                ),

                // Bottom card Items,==> Title, Descp & Button
                child: Column(
                  children: <Widget>[
                    //
                    // Title
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Scan Product Barcode",
                        style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 21.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Descriptions
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Scan the Barcode of product\nand\nsee details its details in system.",
                        style: TextStyle(
                            color: Colors.black26, fontFamily: "Sofia"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.0),

                    // Button
                    InkWell(
                      onTap: () async {
                        String barcodeScanRes;
                        try {
                          barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#56aeff", "Cancel", true, ScanMode.BARCODE);
                          print(barcodeScanRes);
                        } on PlatformException {
                          barcodeScanRes = 'Failed to get platform version.';
                        }
                        barcodeScanRes == "-1"
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Not Exists in our system"),
                                    content: Text(
                                        'Want to see product Details? Scan Again some other Products or add it as New Item from Dashboard.'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  );
                                })
                            : print(
                                "Show the list of products having scanned barcode.");

                        // Navigator.of(context).push(PageRouteBuilder(
                        //     pageBuilder: (_, __, ___) => new message()));
                      },
                      child: Container(
                        height: 45.0,
                        width: 140.0,
                        color: Constants.basicColor,
                        child: Center(
                          child: Text(
                            "Start Scan",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
