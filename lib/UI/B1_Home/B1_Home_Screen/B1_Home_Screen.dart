import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/APIs/APIService.dart';
import 'Search.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/DataModels/ITEMSCounts.dart';
import 'package:total_app/constants.dart';
import 'package:badges/badges.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/editProfile.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:total_app/UI/B4_Review/B4_ReviewScreen.dart';
import 'package:total_app/UI/B4_Review/B4_LowStockScreen.dart';
import 'package:total_app/UI/B4_Review/B4_CurentSaleScreen.dart';
import 'package:total_app/UI/B4_Review/B4_FeaturedScreen.dart';
import 'package:total_app/UI/B4_Review/B4_ReportScreen.dart';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:total_app/UI/B4_Review/BProducts.dart';

class Home extends StatefulWidget {
  Profile profile;

  Home({this.profile});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // CollectionReference ref;
  // CollectionReference refSubCat;
  var companylogo = 'assets/logos.png';
  var companyMainImage = 'assets/Image/banner/banner1Travel.jpg';

  ////counts
  // var countFlagged = 0;
  // var countLowStock = 0;
  // var countItems = 0;
  // // var countReview = 0;
  // var countSale = 0;
  // var countFeatured = 0;
  ITEMSCounts itemsCounts = ITEMSCounts();

  @override
  void initState() {
    // TOD implement initState
    super.initState();

    getCompanyMainIamge(); //
    getCompanyLogo(); //
    getUserProfile();
    // get count
    getCounts();
    // refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  refresh() async {
    ProgressDialog dialog = ProgressDialog(context);
    await dialog.show();
    getCompanyMainIamge();
    getCompanyLogo();
    getUserProfile();
    getCounts();
    setState(() {});
    await dialog.hide();
  }

  refreshOnlyProfile() async {
    getUserProfile();
  }

  getCompanyMainIamge() async {
    companyMainImage = 'assets/logos.png';
    this.companyMainImage =
        await GettingData.getCompanyMainImage(widget.profile.companycode);
    companyMainImage = companyMainImage ?? '';
    if (companyMainImage == '') {
      companyMainImage = 'assets/logos.png';
    }
    setState(() {});
  }

  getCompanyLogo() async {
    companylogo = 'assets/logos.png';

    this.companylogo =
        await GettingData.getCompanyUserDPURL(widget.profile.email);
    companylogo = companylogo ?? '';
    if (companylogo == '') {
      companylogo = 'assets/logos.png';
    }
    setState(() {});
  }

  getUserProfile() async {
    widget.profile = await APIServices.getRegisteredUser(widget.profile.email);
    setState(() {});
  }

  /// Counts
  getCounts() async {
    this.itemsCounts = await GettingData.getCounts(widget.profile.companycode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Constants.basicColor,
    ));

    var _appBar = AppBar(
      backgroundColor: Constants.basicColor,
      title: Text(
        "Dashboard",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontFamily: "Gotik",
          fontSize: 25.0,
          color: Constants.thirdColor,
        ),
      ),
      centerTitle: true,
      brightness: Brightness.light,
      elevation: 0.0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            this.refresh();
          },
        ),
      ],
    );

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
              transitionDuration: Duration(milliseconds: 200),
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

    return Scaffold(
      backgroundColor: Constants.thirdColor,
      appBar: _appBar,
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              /// to-date
              Container(
                color: Constants.basicColor,
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 0, right: 15.0),
                  child: Text(
                    getToday(), // "Monday, feb 2",
                    style: TextStyle(color: Constants.thirdColor),
                  ),
                ),
              ),

              // top picture | Company image and User's name
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  //top picture
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: Constants.basicColor,
                      child: Center(
                        child: Hero(
                          tag: 'iconImage',
                          child: this.companyMainImage == 'assets/logos.png'
                              ? Image.asset(
                                  companyMainImage,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(companyMainImage),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),

                  //user image
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Row(
                        children: [
                          // user image
                          InkWell(
                            onTap: () {
                              refreshOnlyProfile();
                              setState(() {});
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => EditProfile(
                                    profile: widget.profile,
                                  ),
                                  transitionDuration:
                                      Duration(milliseconds: 1000),
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
                              refreshOnlyProfile();
                            },
                            child: Hero(
                              tag: 'hero-tag-profile',
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  image: DecorationImage(
                                    image:
                                        this.companylogo == 'assets/logos.png'
                                            ? AssetImage(
                                                "assets/image/icon/profile.png",
                                              )
                                            : NetworkImage(companylogo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Welcome
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // greetings
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Welcome,",
                                  style: TextStyle(
                                    color: Constants.thirdColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // username
                              Padding(
                                padding: EdgeInsets.only(left: 9.0),
                                child: Text(
                                  // "Demohan",
                                  widget.profile.fullname,
                                  style: TextStyle(
                                    color: Constants.thirdColor,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _searchBox,
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //////////////////// <Flagged>
                                  InkWell(
                                    onTap: () {
                                      //
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  ReviewScreen(
                                                      companycode: widget
                                                          .profile
                                                          .companycode)));
                                      getCounts();
                                    },
                                    child: buildCardButton(
                                        Icons.flag_outlined,
                                        "Flagged",
                                        true,
                                        itemsCounts.flaggedCount),
                                  ),
                                  SizedBox(width: 5),

                                  ////////////////// <Low Stock>
                                  InkWell(
                                    onTap: () {
                                      //
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  LowStockScreen(
                                                      companycode: widget
                                                          .profile
                                                          .companycode)));
                                      getCounts();
                                    },
                                    child: buildCardButton(
                                        Icons.stacked_bar_chart,
                                        "Low Stock",
                                        true,
                                        itemsCounts.lowStockCount),
                                  ),
                                  SizedBox(width: 5),

                                  ////////////////// <Added Items>
                                  InkWell(
                                    onTap: () async {
                                      List<SearchResult> allProducts =
                                          List<SearchResult>();
                                      allProducts =
                                          await GettingData.searchPattern(
                                              widget.profile.companycode, ' ');
                                      setState(() {});
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              new BProducts(
                                            comapanycode:
                                                widget.profile.companycode,
                                            results: allProducts,
                                          ),
                                          transitionsBuilder: (_,
                                              Animation<double> animation,
                                              __,
                                              Widget child) {
                                            return Opacity(
                                              opacity: animation.value,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    },
                                    child: buildCardButton(
                                        Icons.wifi_protected_setup_outlined,
                                        "Updated Items",
                                        true,
                                        itemsCounts.itemsCount),
                                  ),
                                  SizedBox(width: 5),
                                  //
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ////////////////// <Current Sale>
                                  InkWell(
                                    onTap: () {
                                      //
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  CurrentSaleScreen(
                                                      companycode: widget
                                                          .profile
                                                          .companycode)));
                                      getCounts();
                                    },
                                    child: buildCardButton(
                                        Icons.add_business_outlined,
                                        "Current Sale",
                                        true,
                                        itemsCounts.currentSaleCount),
                                  ),
                                  SizedBox(width: 5),

                                  ////////////////// <Featured>
                                  InkWell(
                                    onTap: () {
                                      //
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  FeaturedScreen(
                                                      companycode: widget
                                                          .profile
                                                          .companycode)));
                                      getCounts();
                                    },
                                    child: buildCardButton(
                                        Icons.star,
                                        "Featured",
                                        true,
                                        itemsCounts.featuredCount),
                                  ),
                                  SizedBox(width: 5),

                                  ////////////////// <New keyword>
                                  InkWell(
                                    onTap: () async {
                                      List<SearchResult> allProducts =
                                          List<SearchResult>();
                                      allProducts =
                                          await GettingData.searchNewTag(
                                              widget.profile.companycode);
                                      setState(() {});
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              new BProducts(
                                            comapanycode:
                                                widget.profile.companycode,
                                            results: allProducts,
                                          ),
                                          transitionsBuilder: (_,
                                              Animation<double> animation,
                                              __,
                                              Widget child) {
                                            return Opacity(
                                              opacity: animation.value,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 50),
                                        ),
                                      );
                                    },
                                    child: buildCardButton(
                                        Icons.fiber_new_sharp, "New", false, 0),
                                  ),
                                  //
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //
                                  //
                                  InkWell(
                                    onTap: () {
                                      //
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  ReportScreen(
                                                      companycode: widget
                                                          .profile
                                                          .companycode)));
                                    },
                                    child: buildCardButton(
                                      Icons.receipt_long,
                                      "Reports",
                                      false,
                                      0,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  buildCardButton(
                                      Icons.trending_up, "Trending", false, 0),
                                ],
                              ),
                            ),
                            //
                          ],
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
    );
  }

  Card buildCardButton(var icons, String text, bool badge, int count) {
    return Card(
      child: Container(
        color: Colors.white10,
        height: 95,
        width: MediaQuery.of(context).size.width * 0.27, //100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            badge
                ? Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Badge(
                          padding: EdgeInsets.all(5),
                          toAnimate: false,
                          badgeColor: Colors.grey[300],
                          shape: BadgeShape.circle,
                          position: BadgePosition.topEnd(),
                          //showBadge: false,
                          badgeContent: Text(
                            '$count',
                            style: TextStyle(
                              color: Colors.red,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("")),
                    ),
                  )
                : Text(""),
            Icon(
              // Icons.flag_outlined,
              icons,
              size: 45,
              color: Constants.basicColor,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                // "Flagged",
                text,
                style: TextStyle(
                  color: Constants.secondColor,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getToday() {
    int day = DateTime.now().weekday;
    String dd = day == 1
        ? "Monday"
        : day == 2
            ? "Tuesday"
            : day == 3
                ? "Wednessday"
                : day == 4
                    ? "Thursday"
                    : day == 5
                        ? "Friday"
                        : day == 6
                            ? "Saturday"
                            : "Sunday";
    int month = DateTime.now().month;
    String mm = month == 1
        ? "January"
        : month == 2
            ? "February"
            : month == 3
                ? "March"
                : month == 4
                    ? "April"
                    : month == 5
                        ? "May"
                        : month == 6
                            ? "June"
                            : month == 7
                                ? "July"
                                : month == 8
                                    ? "Auguest"
                                    : month == 9
                                        ? "September"
                                        : month == 10
                                            ? "October"
                                            : month == 11
                                                ? "November"
                                                : "December";
    return dd + ", " + mm + " " + DateTime.now().day.toString();
  }
}
