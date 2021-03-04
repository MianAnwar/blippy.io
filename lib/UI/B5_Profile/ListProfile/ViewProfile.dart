import 'package:flutter/material.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B4_Review/BStaffs.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class ViewEditProfile extends StatefulWidget {
  final Profile profile;
  ViewEditProfile({Key key, this.profile}) : super(key: key);

  @override
  _ViewEditProfileState createState() => _ViewEditProfileState();
}

class _ViewEditProfileState extends State<ViewEditProfile> {
  TextEditingController codeCtrl = TextEditingController();
  var countItems;
  var countStaff;
  var businessName;

  @override
  void initState() {
    // TO: implement initState
    super.initState();
    getPC();
    getSC();
    getBusinessName();
    codeCtrl.text = widget.profile.companycode;
  }

  getPC() async {
    int c = await GettingData.getCountOfProducts(widget.profile.companycode);
    this.countItems = c;
    setState(() {});
  }

  getSC() async {
    int c = await GettingData.getCountOfStaff(
        widget.profile.companycode, widget.profile.email);
    this.countStaff = c;
    setState(() {});
  }

  getBusinessName() async {
    String c = await GettingData.getBusinessName(widget.profile.companycode);
    this.businessName = c;
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
                    child: widget.profile.dpimageURL == ''
                        ? Image(
                            image: AssetImage(
                              'assets/image/icon/profile.png',
                            ),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.profile.dpimageURL),
                              ),
                            ),
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
                                    pageBuilder: (_, __, ___) => BStaffsScreen(
                                          companyCode:
                                              widget.profile.companycode,
                                        )));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${countStaff ?? ''}",
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => BStaffsScreen(
                                          companyCode:
                                              widget.profile.companycode,
                                        )));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${countItems ?? ''}",
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
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
            buildItem(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "${businessName ?? ''} ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                  "Stay Active with us. \n\n\nYour Business information will be here."),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.0, right: 20, left: 20),
              child: Center(
                child: TextFormField(
                  controller: codeCtrl,
                  readOnly: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
