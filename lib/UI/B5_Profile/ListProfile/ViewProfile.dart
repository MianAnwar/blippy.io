import 'package:flutter/material.dart';

import 'package:total_app/constants.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/editProfile.dart';

class ViewEditProfile extends StatefulWidget {
  ViewEditProfile({Key key}) : super(key: key);

  @override
  _ViewEditProfileState createState() => _ViewEditProfileState();
}

class _ViewEditProfileState extends State<ViewEditProfile> {
  Widget buildItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13),
      // color: Colors.amber,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                    tag: '001122ff',
                    child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage(
                        'assets/image/images/GirlProfile.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///////staff and Prodcuts
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 17,
                                backgroundColor:
                                    Constants.basicColor.withOpacity(0.6),
                                child: Icon(
                                  Icons.people,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "154",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Staff",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 17,
                                backgroundColor:
                                    Constants.basicColor.withOpacity(0.6),
                                child: Icon(
                                  Icons.integration_instructions_outlined,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "220",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      // fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    "Products",
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w500,
                                      // fontSize: 16.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  RaisedButton(
                    elevation: 10.0,
                    padding: EdgeInsets.all(5.0),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new EditProfile()));
                    },
                    color: Colors.white,
                    child: Text("view And Edit Profile"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            //
            //
            buildItem(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                "Username",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(Constants.planALine),
            ),
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  String txt, image;
  GestureTapCallback tap;
  double padding;

  Category({this.txt, this.image, this.tap, this.padding});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Image.asset(
                        image,
                        height: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
