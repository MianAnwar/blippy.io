/*

Get data of particular product
update it
then simple go back to remove from flagged



*/
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:total_app/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/reviewDetail1.dart';
import 'package:total_app/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maps.dart';

class ProductDetails extends StatefulWidget {
  final String did;
  ProductDetails({this.did});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double rating = 3.5;
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(40.7078523, -74.008981);

  @override
  void initState() {
    // get from firebase
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId("40.7078523, -74.008981"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;

//attribute icons
    var _icon = Container(
      height: 100.0,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child:
                      _infoCircle("assets/image/icon/wifi.png", "Free Wifi")),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: _infoCircle("assets/image/icon/food.png", "Food")),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: _infoCircle("assets/image/icon/clean.png", "Clean")),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: _infoCircle(
                      "assets/image/icon/monitor.png", "Television")),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: _infoCircle(
                      "assets/image/icon/swimming.png", "Swimming")),
            ],
          ),
        ),
      ),
    );

    var _deals = Container(
      height: 100.0,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: _infoBox(
                      "Top Deals", Colors.deepOrangeAccent, Colors.white)),
              Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child:
                      _infoBox("Sale", Colors.deepOrangeAccent, Colors.white)),
              Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child:
                      _infoBox("Featured", Colors.grey[400], Colors.black45)),
            ],
          ),
        ),
      ),
    );

//description
    var _desc = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            "Description / Comment",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 50.0),
          child: Text(
            "Spend a unforgettable in the enchanting surroundings of the town of Cisternino (reachable from the near airports of Bari and Brindisi). \n\nTrullo Edera offers a heaven of peace and tranquillity, set in an elevated position with a stunning view. It's the perfect place if you like nature. You can stay under an olive tree reading a good book, you can have a walk in the small country streets or go to the nearest beaches.",
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );

// location
    var _location = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Text(
            "Store Map",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 190.0,
              //Google Map
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(40.7078523, -74.008981),
                  zoom: 13.0,
                ),
                markers: _markers,
              ),
            ),
            ///// see map
            Padding(
              padding: EdgeInsets.only(top: 135.0, right: 60.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder: (_, __, ___) => maps()));
                  },
                  child: Container(
                    height: 35.0,
                    width: 95.0,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Center(
                      child: Text("See Map",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Sofia")),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );

    var _ratting = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 1.0,
                spreadRadius: 0.2,
              )
            ]),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 15.0, bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontSize: 14.0),
                                  )),
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        reviewDetail1()));
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, top: 2.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            StarRating(
                              size: 25.0,
                              starCount: 5,
                              rating: 4.0,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 5.0),
                            Text("8 Reviews")
                          ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile1.jpg"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile2.jpg"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile3.jpg"),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    var _relatedPostVar = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Icon(Icons.share),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Share',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Icon(Icons.paste_outlined),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Return Policy',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Icon(Icons.info),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Price Match Policy',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Icon(Icons.question_answer_outlined),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Q&A',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );

    var instock = Container(
      height: 40.0,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          gradient: LinearGradient(
              colors: [
                const Color(0xFF8F03F2),
                Colors.deepOrangeAccent,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Center(
        child: Text(
          "in Stock",
          style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              /// Create Appbar
              delegate: MySliverAppBar(
                expandedHeight: _height - 30.0,
                img: 'widget.image',
                id: 'widget.id',
                title: 'widget.title',
                price: 'widget.price',
                location: 'widget.location',
              ),
              pinned: true,
            ),

            /// Create body
            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  /// For icon row
                  Padding(
                    padding:
                        EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Attributes",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  _icon,

                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place in Store'),
                            SizedBox(height: 10),
                            Text(
                              'Aisle: X',
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Section: Xx',
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Shelf: Y',
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        instock,
                      ],
                    ),
                  ),

                  /// Desc
                  _desc,

                  /// For icon row
                  _deals,

                  /// Location
                  _location,

                  /// Ratting
                  _ratting,

                  ///Related Post
                  _relatedPostVar,
                ])),
          ],
        ),
      ),
    );
  }
}

///////////silver appbar
class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, id, title, price, location;

  MySliverAppBar(
      {@required this.expandedHeight,
      this.img,
      this.id,
      this.title,
      this.price,
      this.location});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.clip,
      children: [
        Container(
          height: 0.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "$title",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-$id',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(img),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 130.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.65),
                            fontSize: 30.5,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w700),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 14.0,
                          color: Colors.black26,
                        ),
                        Text(
                          "Wembley, London",
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 14.5,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w800),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10.0, bottom: 10.0),
                    child: Container(
                      child: Text(
                        '$price',
                        style: TextStyle(
                            color: Color(0xFF8F73F2),
                            fontSize: 25.5,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w800),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _infoCircle(String image, title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            color: Color(0xFFF0E5FB),
          ),
          child: Center(
            child: Image.asset(
              image,
              height: 22.0,
              color: Colors.deepPurple,
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    ],
  );
}

Widget _infoBox(String deal, Color bg, Color tcolor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
          height: 55.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            // color: Color(0xFFF0E5FB),
            color: bg,
            // color: Colors.grey,
          ),
          child: Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '$deal',
              style: TextStyle(
                // color: Colors.deepPurpleAccent.shade400,
                // color: Colors.white,
                color: tcolor,
                fontFamily: "Berlin",
                fontSize: 18,
              ),
            ),
          ))),
    ],
  );
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

Widget _buildRating(
    String date, String details, Function changeRating, String image) {
  return ListTile(
    leading: Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    ),
    title: Row(
      children: <Widget>[
        StarRating(
            size: 20.0,
            rating: 3.5,
            starCount: 5,
            color: Colors.yellow,
            onRatingChanged: changeRating),
        SizedBox(width: 8.0),
        Text(
          date,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    ),
    subtitle: Text(
      details,
      style: TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w300),
    ),
  );
}
