import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/UI/B4_Review/BProducts.dart';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/AddItemScreen.dart';

class BScanning extends StatefulWidget {
  final String companycode;
  BScanning({Key key, this.companycode}) : super(key: key);

  @override
  _BScanningState createState() => _BScanningState();
}

class _BScanningState extends State<BScanning> {
  bool manually = false;
  String barcodeScanRes;
  CollectionReference ref;
  CollectionReference refSubCat;

  @override
  void initState() {
    // TO implement initState
    super.initState();
    ref = (GettingData.getCategoriesReference(widget.companycode));
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      //
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
              alignment: Alignment.center,
              child: Container(
                height: 185,
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
                    // Manually Add New Product
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () async {
                          this.manually = true;
                          // NOW ADD NEW PRODUCT
                          // NOW ADD NEW PRODUCT
                          // NOW ADD NEW PRODUCT
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Add New\nSelect Appropriate Category',
                                  textAlign: TextAlign.center,
                                ),
                                content: StreamBuilder(
                                  stream: ref.snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                          return Column(
                                            children: [
                                              ///////////// Proceed to SubCat
                                              InkWell(
                                                onTap: () {
                                                  print(document
                                                      .data()['CatName']);

                                                  proceedToSubCategories(
                                                      document
                                                          .data()['CatName']);
                                                },
                                                child: _infoCircle(
                                                    document.data()['CatName']),
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
                            },
                          );

                          // NEW PRODUCT ADDED
                          // NEW PRODUCT ADDED
                          // NEW PRODUCT ADDED

                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (_, __, ___) => new message()));
                        },
                        child: Container(
                          height: 45.0,
                          width: 200.0,
                          color: Constants.basicColor,
                          child: Center(
                            child: Text(
                              "Manually Add New Product",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "Sofia"),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // OR
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 21.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),

                    // Starts Scan
                    InkWell(
                      onTap: () async {
                        this.manually = false;

                        try {
                          barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#56aeff", "Cancel", true, ScanMode.BARCODE);
                        } on PlatformException {
                          barcodeScanRes = 'Failed to get platform version.';
                        }
                        if (barcodeScanRes == "-1") {
                          //Not ScannedS
                        } else {
                          // PRoducts
                          List<SearchResult> result =
                              await GettingData.searchByBarcode(
                                  widget.companycode, barcodeScanRes);
                          result.length == 0
                              ? // Navigator.of(context).pop();
                              // NOW ADD NEW PRODUCT
                              // NOW ADD NEW PRODUCT
                              // NOW ADD NEW PRODUCT

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Add New\nSelect Appropriate Category',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: StreamBuilder(
                                        stream: ref.snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container(
                                              width: 10,
                                              height: 10,
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: snapshot.data.docs.map(
                                                  (DocumentSnapshot document) {
                                                return Column(
                                                  children: [
                                                    ///////////// Proceed to SubCat
                                                    InkWell(
                                                      onTap: () {
                                                        print(document
                                                            .data()['CatName']);

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
                                  },
                                )

                              // NEW PRODUCT ADDED
                              // NEW PRODUCT ADDED
                              // NEW PRODUCT ADDED
                              : Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new BProducts(
                                      results: result,
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
                                        Duration(milliseconds: 500),
                                  ),
                                );
                        }

                        // Navigator.of(context).push(PageRouteBuilder(
                        //     pageBuilder: (_, __, ___) => new message()));
                      },
                      child: Container(
                        height: 45.0,
                        width: 140.0,
                        color: Constants.basicColor,
                        child: Center(
                          child: Text(
                            "Starts Scan",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
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
                  newCat, widget.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret = GettingData.saveNewCategory(newCat, widget.companycode);
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
    refSubCat = GettingData.getSubCategoriesReference(widget.companycode, cat);
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
                              companycode: widget.companycode,
                              barcode: this.manually ? '' : barcodeScanRes,
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
          child: Text("Back"),
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
                  cat, newSubCat, widget.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret = GettingData.saveNewSubCategory(
                    cat, newSubCat, widget.companycode);
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
                  newAttri, widget.companycode);
              if (ret == 0) {
                print('Already Exists');
                Constants.showAlertDialogBox(
                    context, 'Alert', 'Already Exists');
              } else if (ret == 1) {
                // print('Now Add');
                ret =
                    GettingData.saveNewAttribute(newAttri, widget.companycode);
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
}
