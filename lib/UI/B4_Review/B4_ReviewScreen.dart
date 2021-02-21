import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/Hotel/HotelList.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({Key key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  //
  /// imageSlider in header layout category detail
  var _imageSlider = Padding(
    padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
    child: Container(
      height: 180.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        dotColor: Colors.transparent,
        dotSize: 5.5,
        dotSpacing: 16.0,
        dotBgColor: Colors.transparent,
        showIndicator: false,
        overlayShadow: false,
        overlayShadowColors: Colors.white.withOpacity(0.9),
        overlayShadowSize: 0.9,
        images: [
          AssetImage("assets/image/banner/banner4Travel.jpg"),
          AssetImage("assets/image/banner/banner4Travel.jpg"),
          AssetImage("assets/image/banner/banner4Travel.jpg"),
          AssetImage("assets/image/banner/banner2Travel.jpg"),
          AssetImage("assets/image/banner/banner3Travel.jpg"),
          AssetImage("assets/image/banner/banner1Travel.jpg"),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Flagged For Review",
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
            // Title + Icon
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Products for Review"),
                  IconButton(
                      onPressed: () {
                        ////
                      },
                      icon: Icon(Icons.swap_vert_circle_rounded)),
                ],
              ),
            ),

            Center(
              child: _icon("Toys", Color(0xFFF07DA4), Color(0xFFF5AE87),
                  Icons.flight_takeoff),
            ),

            Text("Demo..."),
            _imageSlider,
            //
          ],
        ),
      ),
    );
  }

  Widget _icon(String _text, Color _color, _color2, IconData _icon) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            PageRouteBuilder(pageBuilder: (_, __, ___) => new HotelList()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [_color, _color2]),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Center(
                child: Icon(
              _icon,
              color: Colors.white,
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            _text,
            style: TextStyle(fontFamily: "Sofia"),
          )
        ],
      ),
    );
  }
}
