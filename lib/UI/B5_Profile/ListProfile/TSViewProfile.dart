import 'package:flutter/material.dart';
import 'package:total_app/APIs/APIService.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/TSeditProfile.dart';
import 'package:total_app/UI/B4_Review/TStaffs.dart';

class TSViewEditProfile extends StatefulWidget {
  final String email;
  TSViewEditProfile({Key key, this.email}) : super(key: key);

  @override
  _TSViewEditProfileState createState() => _TSViewEditProfileState();
}

class _TSViewEditProfileState extends State<TSViewEditProfile> {
  String username = '-';

  @override
  void initState() {
    // TO: implement initState
    setUSername();
    super.initState();
  }

  setUSername() async {
    this.username = await APIServices.getTestUserName(widget.email);
    setState(() {});
  }

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
                    tag: 'hero-tag-profile',
                    child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage(
                        'assets/image/icon/profile.png',
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
              padding: EdgeInsets.only(left: 5.0),
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        StaffsScreen()));
                              },
                              child: Padding(
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
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new TSEditProfile(
                                email: widget.email,
                              )));
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "$username ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                  "Stay Active with us. \n\n\nYour Business information will be here, \nLocation etc"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text(
                  "You are in test mode.",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
