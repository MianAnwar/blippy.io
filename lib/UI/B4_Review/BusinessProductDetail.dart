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
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/productModel.dart';
import 'package:total_app/APIs/GettingData.dart';

class BusinessProductDetail extends StatefulWidget {
  final String cc;
  final String did;
  BusinessProductDetail({this.did, this.cc});

  @override
  _BusinessProductDetailsStat createState() => _BusinessProductDetailsStat();
}

class _BusinessProductDetailsStat extends State<BusinessProductDetail> {
  Product product = Product();

  ///////////////////////////
  double rating = 3.5;
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(40.7078523, -74.008981);

  @override
  void initState() {
    // get from firebase
    super.initState();
    getProduct();

    //////////////////////////////
    _markers.add(
      Marker(
        markerId: MarkerId("40.7078523, -74.008981"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    //////////////////////////////
  }

  getProduct() async {
    product = await GettingData.getProduct(widget.cc, widget.did);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(product.attributes);
    double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;

//attribute icons
    var _attributess = Container(
      // height: 100.0,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                        'All Natural',
                        product.attributes.contains('All Natural')
                            ? Constants.basicColor
                            : Colors.grey,
                        Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Artisonal',
                      product.attributes.contains('Artisonal')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Keto Friendly',
                      product.attributes.contains('Keto Friendly')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Low Sodium',
                      product.attributes.contains('Low Sodium')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Non GMO',
                      product.attributes.contains('Non GMO')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Organic',
                      product.attributes.contains('Organic')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Peleo Friendly',
                      product.attributes.contains('Peleo Friendly')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'RAW',
                      product.attributes.contains('RAW')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Sugar Conscious',
                      product.attributes.contains('Sugar Conscious')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Vegan',
                      product.attributes.contains('Vegan')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Vegetarian',
                      product.attributes.contains('Vegetarian')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Whole Food Diet',
                      product.attributes.contains('Whole Food Diet')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'NFC Approved',
                      product.attributes.contains('NFC Approved')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Fire Retardan',
                      product.attributes.contains('Fire Retardan')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Clean',
                      product.attributes.contains('Clean')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _attributes(
                      'Cruelty Free',
                      product.attributes.contains('Cruelty Free')
                          ? Constants.basicColor
                          : Colors.grey,
                      Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    var _flagButtonsNSF = Container(
      height: 80.0,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: _infoBox(
                  "New",
                  product.newTag == 'YES'
                      ? Constants.basicColor
                      : Colors.grey[400],
                  product.newTag == 'NO' ? Colors.black45 : Colors.white,
                )),
            Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: _infoBox(
                  "Sale",
                  product.sale == 'YES'
                      ? Constants.basicColor
                      : Colors.grey[400],
                  product.sale == 'YES' ? Colors.white : Colors.black45,
                )),
            Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: _infoBox(
                    "Featured",
                    product.featured == 'YES'
                        ? Constants.basicColor
                        : Colors.grey[400],
                    product.featured == 'YES' ? Colors.white : Colors.black45)),
          ],
        ),
      ),
    );

//description
    var _desc = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 0.0),
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
          padding:
              EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Text(
            "${product.description}",
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
            // textAlign: TextAlign.justify,
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
            // Padding(
            //   padding: EdgeInsets.only(top: 135.0, right: 60.0),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: InkWell(
            //       onTap: () {
            //         Navigator.of(context).push(
            //             PageRouteBuilder(pageBuilder: (_, __, ___) => maps()));
            //       },
            //       child: Container(
            //         height: 35.0,
            //         width: 95.0,
            //         decoration: BoxDecoration(
            //             color: Colors.black12.withOpacity(0.5),
            //             borderRadius: BorderRadius.all(Radius.circular(30.0))),
            //         child: Center(
            //           child: Text("See Map",
            //               style: TextStyle(
            //                   color: Colors.white, fontFamily: "Sofia")),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
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
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Icon(Icons.share),
              TextButton(
                onPressed: () {
                  // share
                },
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
                onPressed: () {
                  // URL Launcher to webpage
                },
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
                onPressed: () {
                  // new page
                },
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
                onPressed: () {
                  // new page
                },
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
      width: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          gradient: LinearGradient(
              colors: [
                Constants.basicColor,
                Colors.deepPurple,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Center(
        child: Text(
          "Stock: ${product.stock} remain",
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
                img: '${product.imageURL ?? ''}',
                title: '${product.title ?? ''}',
                price: 'Sale Price: \$ ${product.salePrice ?? ''}',
                location: 'Location: ${product.place ?? ''}',
              ),
              pinned: true,
            ),

            /// Create body
            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  //
                  /// For place in store and stock
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place in Store', textAlign: TextAlign.center),
                            SizedBox(height: 10),
                            rixhText('Aisle: ', '${product.aisle}'),
                            rixhText('Section: ', '${product.section}'),
                            rixhText('Shelf: ', '${product.shelf}'),
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            instock,
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: rixhText('UOM: ', '${product.uom}'),
                            ),
                            rixhText('P. Cost: ', '\$${product.purchaseCost}'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Desc
                  _desc,

                  /// For icon row
                  _flagButtonsNSF,

                  //

                  product.sale == 'YES'
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, left: 20.0, right: 20.0),
                          child: _dealss(
                            "${product.dealsss}",
                            "${product.startSale}",
                            "${product.endSale}",
                            Constants.basicColor,
                            Colors.white,
                          ),
                        )
                      : SizedBox(),

                  //
                  /// For Cat and SubCat
                  Container(
                    padding: EdgeInsets.only(right: 0, top: 30, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: categorybox(
                                    Icons.category, "${product.category}")),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Sub Category',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: categorybox(
                                    Icons.cast_sharp, "${product.subCat}")),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///////
                  /// For icon row
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Attributes",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  _attributess,

                  /// Location
                  _location,

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
  var options = <String>[
    'Edit',
  ];

  String img, title, price, location;

  MySliverAppBar(
      {@required this.expandedHeight,
      this.img,
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
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: img == ''
                    ? AssetImage('assets/logos.png')
                    : NetworkImage(img),
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
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 14.0,
                          color: Colors.black26,
                        ),
                        Text(
                          "$location",
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            InkWell(
              onTap: () {
                print('sadasdsd');
                // Navigator.of(context).pop();

                // Show More
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 10.0),
                  child: Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        // color: Colors.white,
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Edit') {
                            // Navigatoe to edit screen with (cc,product)
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return options.map(
                            (item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            },
                          ).toList();
                        },
                      )),
                ),
              ),
            ),
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

Widget rixhText(String title, String data) {
  return Text.rich(
    TextSpan(
      text: '$title',
      style: TextStyle(
          fontFamily: "Sofia", fontSize: 17.0, fontWeight: FontWeight.normal),
      children: [
        TextSpan(
          text: "$data",
          style: TextStyle(
              fontFamily: "Sofia", fontSize: 17.0, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget categorybox(var icon, String title) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
        height: 50.0,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          // color: Color(0xFFF0E5FB),
          color: Constants.basicColor.withOpacity(1),
        ),
        child: Center(
            child: Text(
          '$title',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ))),
  );
}

Widget _dealss(String dealName, String sD, String eD, Color bg, Color tcolor) {
  var what = DateTime.now().difference((DateTime.parse(eD))).inDays;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20.0, left: 0.0, right: 20.0),
        child: Text(
          "Deal",
          style: TextStyle(
              fontFamily: "Sofia", fontSize: 20.0, fontWeight: FontWeight.w700),
          textAlign: TextAlign.justify,
        ),
      ),
      SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 60.0,
                width: 125.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: bg.withOpacity(0.8),
                ),
                child: Center(
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '$dealName',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tcolor,
                        fontFamily: "Berlin",
                        fontSize: 17,
                      ),
                    ),
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                rixhText('From: ', '$sD'),
                rixhText('To: ', '$eD'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Validity'),
                Text(
                  '${what == 0 ? 'Last Day' : what == 1 ? 'Expired' : 'Active'}',
                  style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: what == 0
                        ? Colors.amber
                        : what == 1
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _attributes(String attributeName, Color bg, Color tcolor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(55.0)),
            color: bg,
          ),
          child: Center(
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.all(8.0),
              child: Text(
                '$attributeName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: tcolor,
                  fontFamily: "Berlin",
                  fontSize: 15,
                ),
              ),
            ),
          )),
    ],
  );
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
