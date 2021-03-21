import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:intl/intl.dart';
import 'package:total_app/DataModels/productModel.dart';
import 'package:total_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddNewItem extends StatefulWidget {
  final String barcode;
  final String companycode;
  final String category;
  final String subCategory;

  AddNewItem(
      {Key key,
      this.barcode,
      this.companycode,
      this.category,
      this.subCategory})
      : super(key: key);

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  bool saving = false;

  CollectionReference ref;
  CollectionReference refDeals;

  Product newProduct = Product();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  var _addProductKey = GlobalKey<FormState>();

  TextEditingController barcode = TextEditingController();
  TextEditingController aisle = TextEditingController();
  TextEditingController shelf = TextEditingController();
  TextEditingController section = TextEditingController();
  TextEditingController place = TextEditingController();

  String currUOM = 'Package';
  TextEditingController stock = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController nameProduct = TextEditingController();
  TextEditingController description = TextEditingController();

  bool newTag = false;
  bool featured = false;

  var categories;
  var subCategories;
  var startDate = '';
  var endDate = '';

  List<String> attributes = List<String>();
  List<String> selectionDeals = List<String>();
  String selectedDeal = '';

  DateTimeRange dateRange;

  String getFrom() {
    if (dateRange == null) {
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: 2)));
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.end);
    }
  }

  @override
  void initState() {
    super.initState();

    // widget.companycode.companycode
    categories = widget.category;
    subCategories = widget.subCategory;
    this.barcode.text = widget.barcode;
    ref = (GettingData.getAttributesReference(widget.companycode));
    refDeals = (GettingData.getDealsssReference(widget.companycode));
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      saveText: "Save",
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        // maxWidth: 100,// maxHeight: 100,// imageQuality: 1,
      );
      setState(() {
        _imageFile = pickedFile;
      });
      print('Picked');
    } catch (e) {
      print('Error');
      setState(() {
        // _pickImageError = e;
      });
    }
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile.path),
        scale: 0.5,
      );
    } else {
      return Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text('On leaving you will lose information.',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center),
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("Leave"),
                  )
                ],
              );
            });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Are you sure you want to go back,
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text('On leaving you will lose information.',
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text("Leave"),
                          )
                        ],
                      );
                    });
              },
              icon: Icon(Icons.arrow_back_ios)),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Product",
            style: TextStyle(fontFamily: "Sofia", color: Colors.black),
          ),
        ),
        //
        body: ModalProgressHUD(
          inAsyncCall: saving,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    // height: 430.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.red[100],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15.0,
                          spreadRadius: 10.0,
                          color: Colors.white.withOpacity(0.09),
                        )
                      ],
                    ),
                    child: Form(
                      key: _addProductKey,
                      child: Column(
                        children: <Widget>[
                          //
                          //Barcode
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 10.0,
                                top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Barcode",
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Colors.black26,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                // field
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 13.0),
                                    child: TextFormField(
                                        controller: barcode,
                                        validator: (v) {
                                          if (v.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17.0),
                                        decoration: InputDecoration(
                                          hintText: "Enter Barcode",
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17.0),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    //
                                    String barcodeScanRes;
                                    try {
                                      barcodeScanRes =
                                          await FlutterBarcodeScanner
                                              .scanBarcode("#56aeff", "Cancel",
                                                  true, ScanMode.BARCODE);
                                    } on PlatformException {
                                      barcodeScanRes =
                                          'Failed to get platform version.';
                                    }
                                    if (barcodeScanRes != "-1") {
                                      setState(() {
                                        this.barcode.text = barcodeScanRes;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.qr_code_scanner),
                                ),
                              ],
                            ),
                          ),
                          ///////////////////////////////////////////////////////////////
                          Divider(
                            color: Colors.black12.withOpacity(0.1),
                            height: 0.3,
                          ),

///////////////////////////////////////////////////////////////////////////////

                          //Image, Address, Asile, Shelf, Section, Place
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 15.0, bottom: 10.0, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    color:
                                        Constants.basicColor.withOpacity(0.2),
                                    width: double.infinity,
                                    height: 210,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          ///Buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              RaisedButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          color: Colors.white12,
                                                          height: 120,
                                                          child: Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  _onImageButtonPressed(
                                                                      ImageSource
                                                                          .camera,
                                                                      context:
                                                                          context);
                                                                },
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .camera),
                                                                  title: Text(
                                                                      'Camera'),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  _onImageButtonPressed(
                                                                      ImageSource
                                                                          .gallery,
                                                                      context:
                                                                          context);
                                                                },
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .image),
                                                                  title: Text(
                                                                      'Gallery'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text('Pick Image'),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    this._imageFile = null;
                                                  });
                                                },
                                                child: Text('Clear Image'),
                                              ),
                                            ],
                                          ),
                                          _previewImage(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.pin_drop),
                                            Text(
                                              'Location',
                                              style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Aisle  ',
                                              style: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black,
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              width: 30,
                                              child: TextFormField(
                                                controller: aisle,
                                                validator: (v) {
                                                  if (v.isEmpty) {
                                                    return "Required";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'XX',
                                                  hintStyle: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color: Colors.black26,
                                                      // fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  enabledBorder:
                                                      new UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.0,
                                                        style:
                                                            BorderStyle.none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Shelf  ',
                                              style: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black,
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              width: 30,
                                              child: TextFormField(
                                                validator: (v) {
                                                  if (v.isEmpty) {
                                                    return "Required";
                                                  }
                                                  return null;
                                                },
                                                controller: shelf,
                                                decoration: InputDecoration(
                                                  hintText: 'XX',
                                                  hintStyle: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color: Colors.black26,
                                                      // fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  enabledBorder:
                                                      new UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.0,
                                                        style:
                                                            BorderStyle.none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Section  ',
                                              style: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black,
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              width: 30,
                                              child: TextFormField(
                                                validator: (v) {
                                                  if (v.isEmpty) {
                                                    return "Required";
                                                  }
                                                  return null;
                                                },
                                                controller: section,
                                                decoration: InputDecoration(
                                                  hintText: 'XX',
                                                  hintStyle: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color: Colors.black26,
                                                      // fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  enabledBorder:
                                                      new UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.0,
                                                        style:
                                                            BorderStyle.none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Place  ',
                                              style: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black,
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              width: 30,
                                              child: TextFormField(
                                                validator: (v) {
                                                  if (v.isEmpty) {
                                                    return "Required";
                                                  }
                                                  return null;
                                                },
                                                controller: place,
                                                decoration: InputDecoration(
                                                  hintText: 'XX',
                                                  hintStyle: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color: Colors.black26,
                                                      // fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  enabledBorder:
                                                      new UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.0,
                                                        style:
                                                            BorderStyle.none),
                                                  ),
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
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(0.1),
                            height: 0.3,
                          ),

                          //UOM & Stock
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 10.0,
                                top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "UOM",
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Colors.black26,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: DropdownButton<String>(
                                      value: currUOM,
                                      onChanged: (String newSelectedItem) {
                                        setState(() {
                                          currUOM = newSelectedItem;
                                        });
                                      },
                                      items: [
                                        'Package',
                                        'Case',
                                        'Each',
                                        'Can',
                                        'Bag',
                                        'Box',
                                        'Dozen',
                                        'Kg',
                                        'gram',
                                        'Gallon',
                                        'Pound',
                                        'Roll',
                                        'Stack',
                                        'Carton'
                                      ].map((String item) {
                                        return DropdownMenuItem<String>(
                                            value: item, child: Text('$item'));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                ////
                                SizedBox(width: 40),
                                Text(
                                  'Stock',
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Colors.black26,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                        validator: (v) {
                                          try {
                                            int.parse(v);
                                          } catch (e) {
                                            return "Invalid";
                                          }
                                          if (v.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        controller: stock,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '10',
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black26,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(0.1),
                            height: 0.3,
                          ),

//////////////////////////////////////////////////////////////////////////////////////////////////
//
                          // Cost and Sale Price
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 10.0,
                                top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Cost",
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Colors.black26,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                        controller: cost,
                                        validator: (v) {
                                          try {
                                            double.parse(v);
                                          } catch (e) {
                                            return "Invalid";
                                          }
                                          if (v.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '\$120',
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black26,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                  ),
                                ),
                                ////
                                Text(
                                  'Sale Price',
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      color: Colors.black26,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                        validator: (v) {
                                          try {
                                            double.parse(v);
                                          } catch (e) {
                                            return "Invalid";
                                          }
                                          if (v.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        controller: salePrice,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '\$100',
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black26,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(0.1),
                            height: 0.3,
                          ),

//////////////////////////////////////////////////////////////////////////
                          //Name of Product
                          Padding(
                            padding: EdgeInsets.only(
                                left: 13.0, right: 15.0, bottom: 20.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                      validator: (v) {
                                        if (v.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      controller: nameProduct,
                                      decoration: InputDecoration(
                                        hintText: 'Name of Product',
                                        hintStyle: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black26,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.none),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(0.1),
                            height: 0.3,
                          ),

/////////////////////////////////////////////////////////////////////////////////////////////
                          //Description
                          Container(
                            padding: EdgeInsets.only(left: 13, top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Description',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black26,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 13.0, right: 15.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                      validator: (v) {
                                        if (v.isEmpty) {
                                          return "Required";
                                        }
                                        if (v.length < 50) {
                                          return "Must be more than 50 characters long.";
                                        }
                                        return null;
                                      },
                                      controller: description,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
                                        hintStyle: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black26,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.none),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            color: Colors.black12.withOpacity(1),
                            height: 0.3,
                          ),
/////////////////////////////////////////////////////////////////////////////////////////////

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25.0, bottom: 25),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  //
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.newTag = !this.newTag;
                                      });
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, right: 15),
                                        child: _infoBox(
                                          "New",
                                          this.newTag
                                              ? Constants.basicColor
                                              : Colors.grey[400],
                                          this.newTag
                                              ? Colors.white
                                              : Colors.black45,
                                        )),
                                  ),
                                  //

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.featured = !this.featured;
                                      });
                                    },
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 0, right: 15),
                                        child: _infoBox(
                                          "Featured",
                                          this.featured
                                              ? Constants.basicColor
                                              : Colors.grey[400],
                                          this.featured
                                              ? Colors.white
                                              : Colors.black45,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black.withOpacity(1),
                            height: 0.3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
////////////////////////////<Sale & Clearance>////////////////////////////////////////////////

                          Container(
                            padding: EdgeInsets.only(top: 10, left: 20),
                            height: 200,
                            color: Constants.basicColor.withOpacity(0.1),
                            width: double.infinity,
                            child: StreamBuilder(
                              stream: refDeals.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: 50,
                                    height: 30,
                                    color: Colors.black,
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return GridView.count(
                                  crossAxisCount: 4,
                                  // shrinkWrap: true,
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    // print(document.data()['AttName']);
                                    return InkWell(
                                      onTap: () {
                                        String a =
                                            (document.data()['DealsName']);
                                        this.selectedDeal = a;
                                        print(a);

                                        if (this.selectionDeals.contains(a)) {
                                          this.selectionDeals.remove(a);
                                          print('removed');
                                        } else {
                                          if (this.selectionDeals.length != 1) {
                                            this.selectionDeals.add(a);
                                            print('added');
                                          }
                                        }
                                        print(this.selectionDeals.length);

                                        setState(() {});
                                        // print(document.data()['AttName']);
                                      },
                                      child: _dealss(
                                        document.data()['DealsName'],
                                        this.selectionDeals.contains(
                                                document.data()['DealsName'])
                                            ? Constants.basicColor
                                            : Colors.grey,
                                        Colors.white,
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),

////////////////////////////<rance>////////////////////////////////////////////////

                          //Start End Date
                          this.selectionDeals.length > 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Text('Select Date Range'),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              child: Text(getFrom()),
                                              onPressed: () =>
                                                  pickDateRange(context),
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward,
                                              color: Constants.basicColor),
                                          Expanded(
                                            child: OutlinedButton(
                                              child: Text(getUntil()),
                                              onPressed: () =>
                                                  pickDateRange(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Text(''),
                          //
                          //
                          Divider(
                            color: Colors.black12.withOpacity(1),
                            height: 0.3,
                          ),

////////////////////////////<Categories>
                          Container(
                            padding:
                                EdgeInsets.only(right: 0, top: 30, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        child: _infoCircle(
                                            Icons.category, "$categories")),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        child: _infoCircle(Icons.cast_sharp,
                                            "$subCategories")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(1),
                            height: 0.3,
                          ),

                          // Attributes
                          Container(
                            padding:
                                EdgeInsets.only(left: 30, top: 30, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Attributes',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            height: 200,
                            color: Constants.basicColor.withOpacity(0.1),
                            width: double.infinity,
                            child: StreamBuilder(
                              stream: ref.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    // color: Colors.black,
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return GridView.count(
                                  crossAxisCount: 4,
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    // print(document.data()['AttName']);
                                    return InkWell(
                                      onTap: () {
                                        String a = (document.data()['AttName']);
                                        print(this.attributes.length);
                                        if (this.attributes.contains(a)) {
                                          this.attributes.remove(a);
                                          print('removed');
                                        } else {
                                          this.attributes.add(a);
                                          print('added');
                                        }
                                        print(this.attributes.length);
                                        setState(() {});
                                        // print(document.data()['AttName']);
                                      },
                                      child: _attributes(
                                        document.data()['AttName'],
                                        this.attributes.contains(
                                                document.data()['AttName'])
                                            ? Constants.basicColor
                                            : Colors.grey,
                                        Colors.white,
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          //

                          ////
                          ////
                          ////
                          ////
                          ////

                          Padding(
                            padding: EdgeInsets.only(top: 38.0, bottom: 40),
                            child: InkWell(
                              onTap: addItem,
                              child: Container(
                                height: 55,
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.basicColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Add Product",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        letterSpacing: 1.2),
                                  ),
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
          ),
        ),
      ),
    );
  }

  addItem() async {
    setState(() {
      this.saving = true;
    });
    /////
    /////
    // ADD Product
    if (_addProductKey.currentState.validate()) {
      ProgressDialog dialog = ProgressDialog(context);
      await dialog.show();

      // if (_imageFile != null) {
      //   return null;
      // }
      this.newProduct.barcode = this.barcode.text;
      this.newProduct.title = this.nameProduct.text;
      this.newProduct.description = this.description.text;

      this.newProduct.purchaseCost = this.cost.text;
      this.newProduct.salePrice = this.salePrice.text;
      this.newProduct.uom = this.currUOM;
      this.newProduct.stock = this.stock.text;

      this.newProduct.aisle = this.aisle.text;
      this.newProduct.shelf = this.shelf.text;
      this.newProduct.section = this.section.text;
      this.newProduct.place = this.place.text;

      this.newProduct.category = widget.category;
      this.newProduct.subCat = widget.subCategory;
      this.newProduct.attributes = this.attributes;

      this.newProduct.dealsss = this.selectedDeal;

      this.newProduct.sale = this.selectionDeals.length == 1 ? "YES" : "NO";

      //Start End Date
      this.newProduct.startSale = this.getFrom();
      this.newProduct.endSale = this.getUntil();

      this.newProduct.newTag = this.newTag ? "YES" : "NO";

      this.newProduct.featured = this.featured ? "YES" : "NO";

      if (_imageFile != null) {
        bool check =
            await GettingData.checkProduct(newProduct, widget.companycode);
        if (!check) {
          //not exists then save
          // this._imageFile
          if (_imageFile != null) {
            // File(_imageFile.path)
            String url =
                await GettingData.uploadImagetoFirebase(File(_imageFile.path));
            this.newProduct.imageURL = url;
            print(url);
          }
          int response =
              GettingData.saveProduct(newProduct, widget.companycode);
          await dialog.hide();

          if (response == 1) {
            Navigator.of(context).pop();
            Constants.showDialogBox(
                context, 'New Product Added Sucessfully!', '');
          } else {
            Constants.showAlertDialogBox(context,
                'Alert, Couldn\'t Add new Product!', 'Try Again, Later.');
          }
        } else {
          await dialog.hide();

          Constants.showAlertDialogBox(context, 'Alert, Duplication Found',
              'Location is occupied or Similar product already exists in system. ');
        }
      } else {
        await dialog.hide();
        Constants.showAlertDialogBox(
            context, 'Enter All Information', 'Must select Appropriate Image.');
      }
    }
    /////
    setState(() {
      this.saving = false;
    });
    /////
  }

  ////////////
  Widget _infoCircle(var icon, String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          height: 60.0,
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

  Widget _infoBox(String deal, Color bg, Color tcolor) {
    return Container(
        padding: EdgeInsets.all(5),
        height: 55.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: bg,
        ),
        child: Center(
          child: Container(
            // color: Colors.red,
            padding: EdgeInsets.all(8.0),
            child: Text(
              '$deal',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: tcolor,
                fontFamily: "Berlin",
                fontSize: 17,
              ),
            ),
          ),
        ));
  }

  ////////////
  ///
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

  Widget _dealss(String attributeName, Color bg, Color tcolor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 80.0,
            width: 85.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
}
