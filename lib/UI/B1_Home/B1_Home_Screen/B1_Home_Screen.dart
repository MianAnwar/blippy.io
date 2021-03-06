import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/APIs/APIService.dart';
import 'AddItemScreen.dart';
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

class Home extends StatefulWidget {
  Profile profile;

  Home({this.profile});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference ref;
  CollectionReference refSubCat;
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
    ref = (GettingData.getCategoriesReference(widget.profile.companycode));

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
                  padding: const EdgeInsets.only(top: 0, right: 15.0),
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
                                    },
                                    child: buildCardButton(
                                        Icons.flag_outlined,
                                        "Flagged",
                                        true,
                                        itemsCounts.flaggedCount),
                                  ),
                                  //////////////////
                                  SizedBox(width: 5),

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
                                    },
                                    child: buildCardButton(
                                        Icons.account_tree,
                                        "Low Stock",
                                        true,
                                        itemsCounts.lowStockCount),
                                  ),
                                  SizedBox(width: 5),

                                  ///////////
                                  InkWell(
                                    onTap: () {
                                      //

                                      var alterDialog = AlertDialog(
                                        title:
                                            Text('Select Appropriate Category'),
                                        content: StreamBuilder(
                                          stream: ref.snapshots(),
                                          // initialData:  ,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container(
                                                width: 10,
                                                height: 10,
                                                // color: Colors.black,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Column(
                                                children: snapshot.data.docs
                                                    .map((DocumentSnapshot
                                                        document) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();

                                                          print(document.data()[
                                                              'CatName']);
                                                          proceedToSubCategories(
                                                              document.data()[
                                                                  'CatName']);
                                                        },
                                                        child: _infoCircle(
                                                            document.data()[
                                                                'CatName']),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          },
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              // Navigator.of(context).pop();
                                              addNewCategory();
                                            },
                                            child: Text("Add New Category"),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Exit"),
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alterDialog;
                                          });
                                      //
                                    },
                                    child: buildCardButton(
                                        Icons.breakfast_dining,
                                        "Items Add",
                                        true,
                                        itemsCounts.itemsCount),
                                  ),
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
                                  /////////////////////////////////
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
                                    },
                                    child: buildCardButton(
                                        Icons.assignment_turned_in,
                                        "Current Sale",
                                        true,
                                        itemsCounts.currentSaleCount),
                                  ),
                                  //
                                  SizedBox(width: 5),

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
                                    },
                                    child: buildCardButton(
                                        Icons.star,
                                        "Featured",
                                        true,
                                        itemsCounts.featuredCount),
                                  ),
                                  SizedBox(width: 5),

                                  ////////////////////////////////////////////////////////////
                                  /////////////////////////< Add New>/////////////////////////
                                  ////////////////////////////////////////////////////////////
                                  InkWell(
                                    onTap: () {
                                      var alterDialog = AlertDialog(
                                        title: Text('Add New'),
                                        content: Container(
                                          // color: Colors.red[100],
                                          height: 109,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      addNewCategory();
                                                    },
                                                    child: Text('New Category'),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      addNewAttribute();
                                                    },
                                                    child:
                                                        Text('New Attribute'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                        'Update Monthly theme'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Exit"),
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alterDialog;
                                          });
                                      //
                                    },
                                    child: buildCardButton(
                                        Icons.fiber_new_sharp, "New", false, 0),
                                  ),
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
                                    child: buildCardButton(Icons.report_problem,
                                        "Reports", false, 0),
                                  ),
                                  SizedBox(width: 5),
                                  buildCardButton(
                                      Icons.trending_up, "Trending", false, 0),
                                ],
                              ),
                            ),
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

  String newCat;
  var _addCatFormKey = GlobalKey<FormState>();
  addNewCategory() {
    var alterDialog = AlertDialog(
      title: Text('Add New Category'),
      content: Container(
        height: 100,
        child: Form(
          key: _addCatFormKey,
          child: Column(
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
                onChanged: (c) {
                  newCat = c;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () async {
            int ret;
            if (_addCatFormKey.currentState.validate()) {
              ret = await GettingData.checkNewCategory(
                  newCat, widget.profile.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret = GettingData.saveNewCategory(
                    newCat, widget.profile.companycode);
                if (ret != 1) {
                  Constants.showAlertDialogBox(
                      context, 'Alert', 'Couldn\'t Add');
                } else {
                  Navigator.of(context).pop();
                  Constants.showAlertDialogBox(context, 'Added', '');
                }
              } else {
                // print('There is problem.');
              }
            }
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Exit"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alterDialog;
        });
  }

  proceedToSubCategories(String cat) {
    refSubCat =
        GettingData.getSubCategoriesReference(widget.profile.companycode, cat);
    //////////////
    var alterDialog = AlertDialog(
      title: Text('$cat: Sub Category'),
      content: StreamBuilder(
        stream: refSubCat.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: 10,
              height: 10,
              // color: Colors.black,
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        //
                        // print('sdddddddddddddddddddddddd');
                        // print(document.data()['SubCat']);
                        // print(cat);
                        // print('sdddddddddddddddddddddddd');

                        // proceedTo addNew PRoduct with (document.data()['CatName']);
                        ///////////////
                        Navigator.of(context).pop();

                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => AddNewItem(
                              profile: widget.profile,
                              category: cat,
                              subCategory: document.data()['SubCat'],
                            ),
                            transitionDuration: Duration(milliseconds: 1000),
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: _infoCircle(document.data()['SubCat']),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            addNewSubCategory(cat);
          },
          child: Text("Add New SubCategory"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Exit"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alterDialog;
        });

    //////////////
  }

  String newSubCat = '';
  var _addSubCatFormKey = GlobalKey<FormState>();
  addNewSubCategory(String cat) {
    var alterDialog = AlertDialog(
      title: Text('Add New SubCategory'),
      content: Container(
        height: 100,
        child: Form(
          key: _addSubCatFormKey,
          child: Column(
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
                onChanged: (c) {
                  newSubCat = c;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Sub Category',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () async {
            int ret;
            if (_addSubCatFormKey.currentState.validate()) {
              ret = await GettingData.checkNewSubCategory(
                  cat, newSubCat, widget.profile.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret = GettingData.saveNewSubCategory(
                    cat, newSubCat, widget.profile.companycode);
                if (ret != 1) {
                  Constants.showAlertDialogBox(
                      context, 'Alert', 'Couldn\'t Add');
                } else {
                  Navigator.of(context).pop();
                }
              } else {
                // print('There is problem.');
              }
            }
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Exit"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alterDialog;
        });
  }

//////////////////
  String newAttri;
  var _addAttFormKey = GlobalKey<FormState>();
  addNewAttribute() {
    var alterDialog = AlertDialog(
      title: Text('Add New Attribute'),
      content: Container(
        height: 100,
        child: Form(
          key: _addAttFormKey,
          child: Column(
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
                onChanged: (c) {
                  newAttri = c;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Attribute',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () async {
            int ret;
            if (_addAttFormKey.currentState.validate()) {
              ret = await GettingData.checkNewAttribute(
                  newAttri, widget.profile.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret = GettingData.saveNewAttribute(
                    newAttri, widget.profile.companycode);
                if (ret != 1) {
                  Constants.showAlertDialogBox(
                      context, 'Alert', 'Couldn\'t Add');
                } else {
                  Navigator.of(context).pop();
                  Constants.showAlertDialogBox(context, 'Added!', '');
                }
              } else {
                // print('There is problem.');
              }
            }
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Exit"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alterDialog;
        });
  }

  Widget _infoCircle(String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          height: 45.0,
          // width: 85.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            // color: Color(0xFFF0E5FB),
            color: Constants.basicColor.withOpacity(1),
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ))),
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
