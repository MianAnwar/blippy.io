import 'package:total_app/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/TSSettingApp.dart';
import 'package:total_app/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maps.dart';
import 'package:total_app/DataSample/HomeGridRooms.dart';
import 'package:total_app/DataSample/recentSearchesModel.dart';
import 'package:total_app/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:total_app/DataSample/travelModelData.dart';
import 'package:total_app/UI/B1_Home/Destination/BusinessCategories.dart';
import 'package:total_app/UI/B1_Home/Destination/PromoSale.dart';
import 'package:total_app/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:total_app/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class BShopMain extends StatefulWidget {
  final Profile profile;
  BShopMain({Key key, this.profile}) : super(key: key);

  @override
  _BShopMainState createState() => _BShopMainState();
}

class _BShopMainState extends State<BShopMain> {
  // var listImagesURL = [];

  @override
  void initState() {
    // TO implement initState
    super.initState();
    // getCompanyImages();
  }

//////////////////////////////////////
  Widget buildItemsList(String topTitle) {
    return Container(
      padding: EdgeInsets.only(right: 5.0, top: 10.0),
      height: 220.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "$topTitle",
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return CardLastActivity(recentSearchesModelArray[index]);
                },
                itemCount: recentSearchesModelArray.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemsList2(String topTitle) {
    return Container(
      padding: EdgeInsets.only(right: 5.0, top: 10.0),
      height: 220.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "$topTitle",
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return CardLastActivity(recentSearchesModelArray[index]);
                },
                itemCount: recentSearchesModelArray.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  ///  Grid item in bottom of Category
  var _recommendedRooms = SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
            child: Text(
              "Recommended Rooms",
              // style: _txtStyle,
            ),
          ),

          /// To set GridView item
          GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 0.795,
              crossAxisCount: 2,
              primary: false,
              children: List.generate(
                gridItemArray.length,
                (index) => ItemGrid(gridItemArray[index]),
              ))
        ],
      ),
    ),
  );

/////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    var _searchBox = Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
      ),
      child: InkWell(
        onTap: () {
          return Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => new Search(),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Constants.basicColor,
                  size: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Product Item lookup",
                      style: TextStyle(
                        color: Colors.black26,
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w300,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Constants.thirdColor,
          ),
        ),
        backgroundColor: Constants.basicColor,
        centerTitle: true,
        title: Text(
          "My Demo Store",
          style: TextStyle(
            color: Constants.thirdColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              _searchBox,
              SizedBox(height: 3.0),

              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            new CategoriesScreen(title: 'Categories'),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.category,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Category',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            new PromoSale(title: 'Promos & Sales'),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Promos & Sales',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

// theme
              Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  '\"Monthly Theme\"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Image.network(
                          'https://iogames.space/sites/default/files/Ee1nLJwWAAU6yhC.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // Image.asset('assets/image/room/room9.jpg'),
                      Container(
                        color: Colors.grey,
                        child: Text(
                          ' Valentines Day .',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            color: Colors.white,
                            // fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //
              buildItemsList('New'),

              buildItemsList('Feature items'),
              buildItemsList('Top Deal'),

              buildItemsList('Low Stock'),
              buildItemsList('Out of Stock'),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 20.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.justify,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => TSAppSetting()));
                            },
                            child: Text('Edit')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 190.0,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(40.7078523, -74.008981),
                              zoom: 13.0,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId("40.7078523, -74.008981"),
                                position: LatLng(40.7078523, -74.008981),
                                icon: BitmapDescriptor.defaultMarker,
                              ),
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 135.0, right: 60.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => maps()));
                              },
                              child: Container(
                                height: 35.0,
                                width: 95.0,
                                decoration: BoxDecoration(
                                    color: Colors.black12.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Center(
                                  child: Text("See Map",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Sofia")),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // _recommended,

              SizedBox(height: 200.0),
              Text('0'),
            ],
          ),
        ),
      ),
    );
  }
}

///

class cardList extends StatelessWidget {
  var _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  travelListData hotelData;

  cardList(this.hotelData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(
                    title: hotelData.name,
                    id: hotelData.id,
                    image: hotelData.img,
                    location: hotelData.location,
                    price: hotelData.price,
                    ratting: hotelData.rating,
                  ),
              transitionDuration: Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Container(
          height: 250.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(children: [
            Hero(
              tag: 'hero-tag-${hotelData.id}',
              child: Material(
                child: Container(
                  height: 165.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    image: DecorationImage(
                        image: AssetImage(hotelData.img), fit: BoxFit.cover),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 220.0,
                            child: Text(
                              hotelData.name,
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: hotelData.rating,
                              color: Colors.blueAccent,
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              "(" + hotelData.rating.toString() + ")",
                              style: _txtStyleSub,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 16.0,
                                color: Colors.black26,
                              ),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(hotelData.location, style: _txtStyleSub)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\$" + hotelData.price,
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Widget _card(String image, title, location, ratting, id, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new hotelDetail(
                      title: title,
                      id: id,
                      image: image,
                      location: location,
                      price: ratting,
                    ),
                transitionDuration: Duration(milliseconds: 600),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }));
          },
          child: Hero(
            tag: 'hero-tag-$id',
            child: Material(
              child: Container(
                height: 220.0,
                width: 160.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 2.0)
                    ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              color: Colors.black87),
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 18.0,
              color: Colors.black12,
            ),
            Text(
              location,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.black26),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 18.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                ratting,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),
            SizedBox(
              width: 35.0,
            ),
            Container(
              height: 27.0,
              width: 82.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Center(
                child: Text("Discount 15%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0)),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

////////
class cardCountry extends StatelessWidget {
  Color colorTop, colorBottom;
  String image, title;
  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 105.0,
              width: 105.0,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(
                    colors: [colorTop, colorBottom],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      image,
                      height: 60,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Sofia",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////Featured items
class CardLastActivity extends StatelessWidget {
  final recentSearchesModel searchesModel;

  CardLastActivity(this.searchesModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail(
                    title: searchesModel.title,
                    id: searchesModel.id,
                    image: searchesModel.img,
                    location: searchesModel.price,
                    price: searchesModel.price,
                  ),
              transitionDuration: Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Hero(
                  //   tag: 'hero-tag-${searchesModel.id}',
                  //   child:
                  Material(
                    child: Container(
                      height: 100.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0)),
                          image: DecorationImage(
                              image: AssetImage(searchesModel.img),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  // ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 110.0,
                      child: Text(
                        searchesModel.title,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 0.0),
                    child: Text(
                      searchesModel.price,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardDestinationPopuler extends StatelessWidget {
  String img, txt;
  cardDestinationPopuler({this.img, this.txt});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => new destination(
        //           title: this.txt,
        //         ),
        //     transitionDuration: Duration(milliseconds: 600),
        //     transitionsBuilder:
        //         (_, Animation<double> animation, __, Widget child) {
        //       return Opacity(
        //         opacity: animation.value,
        //         child: child,
        //       );
        //     }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400.0,
          width: 140.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0)
              ]),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                  fontFamily: 'Amira',
                  color: Colors.white,
                  fontSize: 40.0,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  GridItem gridItem;
  ItemGrid(this.gridItem);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(
                    title: gridItem.title,
                    id: gridItem.id,
                    image: gridItem.img,
                    location: gridItem.location,
                    price: gridItem.price,
                    ratting: gridItem.ratingValue,
                  ),
              transitionDuration: Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Hero(
                    tag: 'hero-tag-${gridItem.id}',
                    child: Material(
                      child: Container(
                        height: mediaQueryData.size.height / 5.8,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: AssetImage(gridItem.img),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 130.0,
                      child: Text(
                        gridItem.title,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.0)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: Text(
                          gridItem.price,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                      ),
                      Text(
                        "/night",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: gridItem.ratingValue,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                gridItem.ratingValue.toString(),
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
