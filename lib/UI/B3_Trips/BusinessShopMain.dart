import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/DataModels/SaleResult.dart';
import 'package:total_app/DataModels/SearchLowStock.dart';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:flutter/material.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/SettingApp.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/UploadImage.dart';
import 'package:total_app/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:total_app/UI/B1_Home/Destination/BusinessCategories.dart';
import 'package:total_app/UI/B1_Home/Destination/PromoSale.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/DataModels/BusinessModel.dart';
import 'package:total_app/APIs/APIService.dart';
import 'package:total_app/UI/B4_Review/BusinessProductDetail.dart';

class BShopMain extends StatefulWidget {
  final Profile profile;
  BShopMain({Key key, this.profile}) : super(key: key);

  @override
  _BShopMainState createState() => _BShopMainState();
}

class _BShopMainState extends State<BShopMain> {
  Business business = Business();
  List<SearchResult> newTagProducts = List<SearchResult>();
  List<SearchResult> featuredProducts = List<SearchResult>();
  List<SaleResult> topDeal = List<SaleResult>();
  List<SearchLowStock> lowStockResult = List<SearchLowStock>();

  // var listImagesURL = [];

  @override
  void initState() {
    // TO implement initState
    super.initState();
    // getCompanyImages();
    refresh();
    loadNewTagged();
    loadFeatured();
    loadSaleTopDeal();
    loadLowStock();
  }

  refresh() async {
    this.business = await APIServices.getBusiness(widget.profile.companycode);
    setState(() {});
  }

  loadNewTagged() async {
    newTagProducts = await GettingData.searchNewTag(widget.profile.companycode);
    setState(() {});
  }

  loadFeatured() async {
    featuredProducts =
        await GettingData.featuredProdcuts(widget.profile.companycode);
    setState(() {});
  }

  loadSaleTopDeal() async {
    topDeal = await GettingData.currentSales(widget.profile.companycode);
    setState(() {});
  }

  loadLowStock() async {
    lowStockResult =
        await GettingData.lowStockProducts(widget.profile.companycode);
    setState(() {});
  }

//////////////////////////////////////
  Widget buildItemsListNew(String topTitle) {
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
                  return CardLastActivityNew(
                      newTagProducts[index], widget.profile.companycode);
                },
                itemCount: newTagProducts.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemsListFeatured(String topTitle) {
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
                  return CardLastActivityFeatured(
                      featuredProducts[index], widget.profile.companycode);
                },
                itemCount: featuredProducts.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemsListTopDeal(String topTitle) {
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
                  return CardLastActivityTopDeal(
                      topDeal[index], widget.profile.companycode);
                },
                itemCount: topDeal.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemsListLowStock(String topTitle) {
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
                  return CardLastActivityLowStock(
                      lowStockResult[index], widget.profile.companycode);
                },
                itemCount: lowStockResult.length,
              ),
            ),
          )
        ],
      ),
    );
  }

/////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    var _searchBox = Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          return Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => new Search(
                companycode: widget.profile.companycode,
              ),
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
          "My Store Front",
          style: TextStyle(
            color: Constants.thirdColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      //
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              _searchBox,
              SizedBox(height: 3.0),

              // Categories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            CategoriesScreen(title: 'Categories'),
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

              // Promos & Sales
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

              // theme Headiong
              InkWell(
                onTap: () {
                  // Edit
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => UploadImage(
                            title: "Change Monthly Theme",
                          )));
                  refresh();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    '... \"Monthly Theme\" ...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              // theme image + Text
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.network(
                      this.business.themeURL == '' ||
                              this.business.themeURL == null
                          ? 'https://iogames.space/sites/default/files/Ee1nLJwWAAU6yhC.png'
                          : this.business.themeURL,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),

              //
              buildItemsListNew('New'),

              buildItemsListFeatured('Feature items'),

              buildItemsListTopDeal('Top Deal'),

              buildItemsListLowStock('Low Stock'),

              // Location
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
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => SettingApp(),
                                  transitionDuration:
                                      Duration(milliseconds: 10),
                                  transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                    return Opacity(
                                      opacity: animation.value,
                                      child: child,
                                    );
                                  },
                                ),
                              );
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
                              target: LatLng(40.7078523, 74.008981),
                              zoom: 13.0,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId("40.7078523, 74.008981"),
                                position: LatLng(40.7078523, 74.008981),
                                icon: BitmapDescriptor.defaultMarker,
                              ),
                            },
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(top: 135.0, right: 60.0),
                        //   child: Align(
                        //     alignment: Alignment.bottomRight,
                        //     child: InkWell(
                        //       onTap: () {
                        //         Navigator.of(context).push(PageRouteBuilder(
                        //             pageBuilder: (_, __, ___) => maps()));
                        //       },
                        //       child: Container(
                        //         height: 35.0,
                        //         width: 95.0,
                        //         decoration: BoxDecoration(
                        //             color: Colors.black12.withOpacity(0.5),
                        //             borderRadius: BorderRadius.all(
                        //                 Radius.circular(30.0))),
                        //         child: Center(
                        //           child: Text("See Map",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontFamily: "Sofia")),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),

              // _recommendedRooms,

              SizedBox(height: 200.0),
              Text('0'),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
///

//////////Featured items
class CardLastActivityNew extends StatelessWidget {
  final SearchResult searchesModel;
  final String cc;
  CardLastActivityNew(
    this.searchesModel,
    this.cc,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          print(searchesModel.did);
          print(cc);

          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => BusinessProductDetail(
                    cc: cc,
                    did: searchesModel.did,
                  )));
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
                              image: searchesModel.imageURL == ''
                                  ? AssetImage('assets/image/icon/box.png')
                                  : NetworkImage(searchesModel.imageURL),
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
                  // Padding(padding: EdgeInsets.only(top: 2.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 0.0),
                    child: Row(
                      children: [
                        Text(
                          '\$${searchesModel.salePrice}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Card(
                            elevation: 5,
                            child: Text(
                              ' New ',
                              style: TextStyle(
                                // backgroundColor: Colors.white54,
                                color: Colors.black,
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
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

//////////Featured items
class CardLastActivityFeatured extends StatelessWidget {
  final SearchResult searchesModel;
  final String cc;
  CardLastActivityFeatured(this.searchesModel, this.cc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          print(searchesModel.did);
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => BusinessProductDetail(
                    cc: cc,
                    did: searchesModel.did,
                  )));
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
                              image: searchesModel.imageURL == ''
                                  ? AssetImage('assets/image/icon/box.png')
                                  : NetworkImage(searchesModel.imageURL),
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
                  // Padding(padding: EdgeInsets.only(top: 2.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 0.0),
                    child: Row(
                      children: [
                        Text(
                          '\$${searchesModel.salePrice}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Card(
                            elevation: 5,
                            child: Text(
                              ' Featured ',
                              style: TextStyle(
                                // backgroundColor: Colors.white54,
                                color: Colors.black,
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold,
                                // fontSize: 18.0,
                              ),
                            ),
                          ),
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

class CardLastActivityLowStock extends StatelessWidget {
  final SearchLowStock lowStockData;
  final String cc;
  CardLastActivityLowStock(this.lowStockData, this.cc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          print(lowStockData.did);
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => BusinessProductDetail(
                    cc: cc,
                    did: lowStockData.did,
                  )));
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
                  //   tag: 'hero-tag-${lowStockData.id}',
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
                              image: lowStockData.imageURL == ''
                                  ? AssetImage('assets/image/icon/box.png')
                                  : NetworkImage(lowStockData.imageURL),
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
                        lowStockData.title,
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${lowStockData.salePrice}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.w800,
                                fontSize: 16.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Stock: ${lowStockData.stock}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
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

//////////Featured items
class CardLastActivityTopDeal extends StatelessWidget {
  final SaleResult searchesModel;
  final String cc;
  CardLastActivityTopDeal(this.searchesModel, this.cc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          print(searchesModel.did);
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => BusinessProductDetail(
                    cc: cc,
                    did: searchesModel.did,
                  )));
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
                              image: searchesModel.imageURL == ''
                                  ? AssetImage('assets/image/icon/box.png')
                                  : NetworkImage(searchesModel.imageURL),
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
                  Padding(padding: EdgeInsets.only(top: 4.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 0.0),
                    child: Row(
                      children: [
                        Text(
                          '\$${searchesModel.salePrice}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            ' Deal ',
                            style: TextStyle(
                              backgroundColor: Colors.black26,
                              color: Colors.white,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
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
