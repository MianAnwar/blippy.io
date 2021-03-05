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
import 'package:total_app/DataModels/ProfileModel.dart';

class AddNewItem extends StatefulWidget {
  final Profile profile;
  final String category;
  final String subCategory;

  AddNewItem({Key key, this.profile, this.category, this.subCategory})
      : super(key: key);

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  Product newProduct = Product();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  var _addProductKey = GlobalKey<FormState>();

  TextEditingController barcode = TextEditingController();
  TextEditingController address = TextEditingController();
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

  TextEditingController attriburtes = TextEditingController();

  bool topDeals = false;
  bool sale = false;
  bool featured = false;

  var categories;
  var subCategories;
  var startDate = '';
  var endDate = '';

  DateTimeRange dateRange;

  String getFrom() {
    if (!sale) return '';
    if (dateRange == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.start);
    }
  }

  String getUntil() {
    if (!sale) return '';

    if (dateRange == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.end);
    }
  }

/*
  ::Attributes::
1 -overstock
2 -rollbacks
3 -low prices
4 -special buys
5 -2 day flash deals
6 -3 day flash deals
7 -weekly sales
8 -top deals
9 -member deals
*/

  @override
  void initState() {
    super.initState();
    // widget.profile.companycode
    categories = widget.category;
    subCategories = widget.subCategory;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Product",
          style: TextStyle(fontFamily: "Sofia", color: Colors.black),
        ),
      ),
      //
      body: SingleChildScrollView(
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
                            left: 15.0, right: 15.0, bottom: 10.0, top: 5.0),
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
                                      enabledBorder: new UnderlineInputBorder(
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
                                      await FlutterBarcodeScanner.scanBarcode(
                                          "#56aeff",
                                          "Cancel",
                                          true,
                                          ScanMode.BARCODE);
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
                                color: Constants.basicColor,
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
                                                                  Icons.camera),
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
                                                                  Icons.image),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.pin_drop),
                                        Container(
                                          width: 80,
                                          child: TextFormField(
                                            validator: (v) {
                                              if (v.isEmpty) {
                                                return "Required";
                                              }
                                              return null;
                                            },
                                            controller: address,
                                            decoration: InputDecoration(
                                              hintText: 'Address',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Sofia",
                                                  color: Colors.black26,
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
                                              ),
                                            ),
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
                                                  fontWeight: FontWeight.w700),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
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
                                                  fontWeight: FontWeight.w700),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
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
                                                  fontWeight: FontWeight.w700),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
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
                                                  fontWeight: FontWeight.w700),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.none),
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
                            left: 15.0, right: 15.0, bottom: 10.0, top: 10.0),
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
                                      enabledBorder: new UnderlineInputBorder(
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
                            left: 15.0, right: 15.0, bottom: 10.0, top: 10.0),
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
                                      enabledBorder: new UnderlineInputBorder(
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
                                      enabledBorder: new UnderlineInputBorder(
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
                      ///
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
                      //Description
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
                                        'DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription',
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
///////////////////////////////////////////////////////////////////////////////

                      Divider(
                        color: Colors.black12.withOpacity(0.1),
                        height: 2.3,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(top: 9.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    this.topDeals = !this.topDeals;
                                  });
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 15.0, right: 15),
                                    child: _infoBox(
                                      "Top Deals",
                                      this.topDeals
                                          ? Constants.basicColor
                                          : Colors.grey[400],
                                      this.topDeals
                                          ? Colors.white
                                          : Colors.black45,
                                    )),
                              ),
                              //

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    this.sale = !this.sale;
                                  });
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 0, right: 15),
                                    child: _infoBox(
                                      "Sale",
                                      this.sale
                                          ? Constants.basicColor
                                          : Colors.grey[400],
                                      this.sale ? Colors.white : Colors.black45,
                                    )),
                              ),

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

                      //Start End Date

                      sale
                          ? Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    child: Text(getFrom()),
                                    onPressed: () => pickDateRange(context),
                                  ),
                                ),
                                Icon(Icons.arrow_forward,
                                    color: Constants.basicColor),
                                Expanded(
                                  child: OutlinedButton(
                                    child: Text(getUntil()),
                                    onPressed: () => pickDateRange(context),
                                  ),
                                ),
                              ],
                            )
                          : Text(''),
                      //
                      /// Categories
                      Container(
                        padding: EdgeInsets.only(right: 0, top: 30),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Catregory',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sub Catregory',
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
                                        Icons.cast_sharp, "$subCategories")),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Attributes
                      Container(
                        padding: EdgeInsets.only(left: 30, top: 30),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Attributes',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                  controller: attriburtes,
                                  validator: (v) {
                                    if (v.isEmpty) {
                                      return "Required";
                                    }
                                    if (v.length < 10) {
                                      return "Must be more than 10 characters";
                                    }
                                    return null;
                                  },
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText:
                                        '\t\t\tTags, Attributes\n commma-separated',
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

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: 10.0),
                      //     child: Column(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: <Widget>[
                      //         Row(
                      //           children: [
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //           ],
                      //         ),
                      //         SizedBox(height: 10),
                      //         Row(
                      //           children: [
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //             Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 15.0, right: 0),
                      //                 child: _infoBox(
                      //                     "KK",
                      //                     Constants.basicColor.withOpacity(0.67),
                      //                     Colors.white)),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.only(top: 38.0, bottom: 40),
                        child: InkWell(
                          onTap: () async {
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
                              this.newProduct.description =
                                  this.description.text;

                              this.newProduct.purchaseCost = this.cost.text;
                              this.newProduct.salePrice = this.salePrice.text;
                              this.newProduct.uom = this.currUOM;
                              this.newProduct.stock = this.stock.text;

                              this.newProduct.category = widget.category;

                              this.newProduct.subCat = widget.subCategory;
                              this.newProduct.attributes =
                                  this.attriburtes.text;

                              this.newProduct.address = this.address.text;
                              this.newProduct.aisle = this.aisle.text;
                              this.newProduct.shelf = this.shelf.text;
                              this.newProduct.section = this.section.text;
                              this.newProduct.place = this.place.text;

                              this.newProduct.sale = this.sale ? "YES" : "NO";
                              //Start End Date
                              this.newProduct.topDeal =
                                  this.topDeals ? "YES" : "NO";

                              this.newProduct.featured =
                                  this.featured ? "YES" : "NO";
                              this.newProduct.startSale = this.getFrom();
                              this.newProduct.endSale = this.getUntil();

                              if (_imageFile != null) {
                                bool check = await GettingData.checkProduct(
                                    newProduct, widget.profile.companycode);
                                if (!check) {
                                  //not exists then save
                                  // this._imageFile
                                  if (_imageFile != null) {
                                    // File(_imageFile.path)
                                    String url =
                                        await GettingData.uploadImagetoFirebase(
                                            File(_imageFile.path));
                                    this.newProduct.imageURL = url;
                                    print(url);
                                  }
                                  int response = GettingData.saveProduct(
                                      newProduct, widget.profile.companycode);
                                  await dialog.hide();

                                  if (response == 1) {
                                    Navigator.of(context).pop();
                                  } else {
                                    Constants.showAlertDialogBox(
                                        context,
                                        'Alert, Couldn\'t Add new Product!',
                                        'Try Again, Later.');
                                  }
                                } else {
                                  await dialog.hide();

                                  Constants.showAlertDialogBox(
                                      context,
                                      'Alert, Duplication Found',
                                      'Location is occupied or Similar product already exists in system. ');
                                }
                              } else {
                                await dialog.hide();
                                Constants.showAlertDialogBox(
                                    context,
                                    'Enter All Information',
                                    'Must select Appropriate Image.');
                              }
                            }
                            /////

                            /////
                          },
                          child: Container(
                            height: 55,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
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
    );
  }

  ////////////
  Widget _infoCircle(var icon, String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          height: 110.0,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            // color: Color(0xFFF0E5FB),
            color: Constants.basicColor.withOpacity(1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              Center(
                  child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          )),
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
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: bg,
            ),
            child: Center(
                child: Text(
              '$deal',
              style: TextStyle(
                color: tcolor,
                fontFamily: "Berlin",
                fontSize: 18,
              ),
            ))),
      ],
    );
  }
  ////////////
}
