import 'package:flutter/material.dart';
import 'package:total_app/UI/B1_Home/Hotel/HotelList.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:total_app/constants.dart';

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
          AssetImage("assets/image/banner/banner2Travel.jpg"),
          AssetImage("assets/image/banner/banner3Travel.jpg"),
          AssetImage("assets/image/banner/banner1Travel.jpg"),
        ],
      ),
    ),
  );

  // Text _buildRatingStars(int rating) {
  //   String stars = '';
  //   for (int i = 0; i < rating; i++) {
  //     stars += '⭐ ';
  //   }
  //   stars.trim();
  //   return Text(stars);
  // }

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
            // Title + Icon,     Products for Review
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

            // Center(
            //   child: _icon("Toys", Color(0xFFF07DA4), Color(0xFFF5AE87),
            //       Icons.flight_takeoff),
            // ),

            buildCard(),
            Divider(),

            buildItem(),

            _imageSlider,
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Submit"),
        backgroundColor: Constants.basicColor,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildItem() {
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
                    width: 120,
                    height: 120,
                    image: AssetImage(
                      'assets/image/banner/banner3Travel.jpg',
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
                    "3D Sound Headphone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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

  Widget buildCard() {
    return Container(
      // color: Colors.amber,
      child: ListTile(
        leading: Image(
          width: 80,
          height: 80,
          image: AssetImage(
            'assets/image/banner/banner1Travel.jpg',
          ),
          fit: BoxFit.cover,
        ),
        title: Text('Prodcut Title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 15.0,
                        ),
                        Text(
                          " Flag ",
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  ' by SubTitle',
                ),
              ],
            ),
            Divider(height: 3),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 15.0,
                        ),
                        Text(" Flag "),
                      ],
                    ),
                  ),
                ),
                Text(' by SubTitle'),
              ],
            ),
          ],
        ),
        trailing: Checkbox(
          onChanged: null,
          value: true,
        ),
      ),
    );
  }

  // Widget _icon(String _text, Color _color, _color2, IconData _icon) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.of(context).push(
  //           PageRouteBuilder(pageBuilder: (_, __, ___) => new HotelList()));
  //     },
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           height: 50.0,
  //           width: 50.0,
  //           decoration: BoxDecoration(
  //               gradient: LinearGradient(colors: [_color, _color2]),
  //               borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //           child: Center(
  //               child: Icon(
  //             _icon,
  //             color: Colors.white,
  //           )),
  //         ),
  //         SizedBox(
  //           height: 10.0,
  //         ),
  //         Text(
  //           _text,
  //           style: TextStyle(fontFamily: "Sofia"),
  //         )
  //       ],
  //     ),
  //   );
  // }

}
