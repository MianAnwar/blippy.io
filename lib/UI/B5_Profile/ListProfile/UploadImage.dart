import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:total_app/constants.dart';

class UploadImage extends StatefulWidget {
  final int optionWhere;
  final String title;
  final String companycode;

  UploadImage({Key key, this.optionWhere, this.title, this.companycode})
      : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source, imageQuality: 90
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
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: TextStyle(fontFamily: "Sofia", color: Colors.black),
        ),
      ),
      //
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0, top: 0),
              color: Constants.basicColor.withOpacity(0.3),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ///Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Navigator.of(context).pop();
                                            _onImageButtonPressed(
                                                ImageSource.camera,
                                                context: context);
                                          },
                                          child: ListTile(
                                            leading: Icon(Icons.camera),
                                            title: Text('Camera'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _onImageButtonPressed(
                                                ImageSource.gallery,
                                                context: context);
                                          },
                                          child: ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text('Gallery'),
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

            //
            Container(
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0, top: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (widget.optionWhere == 1) {
                        // Business  Image
                      } else if (widget.optionWhere == 2) {
                        // Display Image 'USER'
                      } else if (widget.optionWhere == 3) {
                        //   Image
                      }
                    },
                    child: Text('Upload & Set'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
