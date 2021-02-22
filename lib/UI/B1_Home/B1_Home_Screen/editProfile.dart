import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Account",
            style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                print("Saved");
                Navigator.of(context).pop();
              },
              child: Text("Save",
                  style: TextStyle(
                    color: Color(0xFF56aeff),
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 17.0,
                  )),
            ),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Container(
                        height: 430.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                              spreadRadius: 10.0,
                              color: Colors.black12.withOpacity(0.03),
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50.0),

                            //Username
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 50.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // username field
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                          hintText: 'Alissa Hearth',
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
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
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),

                            //Email
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                        hintText: 'alissahearth@gmail.com',
                                        hintStyle: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0),
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

                            //Contact Number
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Contact#",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                        hintText: '+1 403 43454312',
                                        hintStyle: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
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
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),

                            //Address
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black26,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 40.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                        hintText: 'Building 2 Street 32R',
                                        hintStyle: TextStyle(
                                            fontFamily: "Sofia",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
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
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 1.3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'hero-tag-profile',
                      child: Container(
                        height: 130.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/image/images/GirlProfile.png",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 80.0, left: 90.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FlatButton(
        onPressed: () {
          var alterDialog = AlertDialog(
            title: Text('Alert'),
            content: Text(
                'Are you sure to Delete your Account?\n It will erase all data from our system.'),
            actions: [
              FlatButton(
                onPressed: () {
                  //
                },
                child: Text("Yes"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"),
              ),
            ],
          );
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alterDialog;
              });
        },
        color: Colors.red,
        child: Text(
          'Delete My Store Permanently',
          // 'Delete My Account Permanently',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
