import 'package:flutter/material.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:total_app/UI/B4_Review/BProducts.dart';
import 'package:total_app/UI/IntroApps/PlanBSignup.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B4_Review/BStaffs.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

import 'SettingApp.dart';

class ViewEditProfile extends StatefulWidget {
  final Profile profile;
  ViewEditProfile({Key key, this.profile}) : super(key: key);

  @override
  _ViewEditProfileState createState() => _ViewEditProfileState();
}

class _ViewEditProfileState extends State<ViewEditProfile> {
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController businessemailCtrl = TextEditingController();
  TextEditingController businessAddressCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController ownerNameCtrl = TextEditingController();

  var countItems;
  var countStaff;
  var businessName;
  String companylogo;

  @override
  void initState() {
    // TO: implement initState
    super.initState();
    getPC();
    getSC();
    getBusinessName();
    getCompanyLogo();
    codeCtrl.text = widget.profile.companycode;
    businessemailCtrl.text = widget.profile.email;
    contactCtrl.text = widget.profile.contactNo;
    ownerNameCtrl.text = widget.profile.fullname;
    // businessAddressCtrl.text //;
  }

  refresh() {
    getPC();
    getSC();
    getBusinessName();
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SettingApp(),
                        transitionDuration: Duration(milliseconds: 10),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Hero(
                      tag: 'hero-tag-profile',
                      child: companylogo == 'assets/logos.png'
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
                                  image: NetworkImage(companylogo),
                                ),
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
                                          profile: widget.profile,
                                        )));
                                refresh();
                                setState(() {});
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
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
                              onTap: () async {
                                List<SearchResult> allProducts =
                                    List<SearchResult>();
                                allProducts = await GettingData.searchPattern(
                                    widget.profile.companycode, ' ');
                                setState(() {});
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new BProducts(
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
                                        Duration(milliseconds: 500),
                                  ),
                                );
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
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Hire Staff'),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => PlanBSignup(
                        companyCode: widget.profile.companycode,
                      )));
            },
            icon: Icon(Icons.history_edu_sharp),
          ),
        ],
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

            /////////////////////

/////////////////////////////////
            Padding(
              padding: EdgeInsets.only(top: 60.0, right: 20, left: 20),
              child: Text(
                'Company Code: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, right: 20, left: 20),
              child: Center(
                child: TextFormField(
                  controller: codeCtrl,
                  readOnly: true,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Text(
                'Company Email: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Center(
                child: TextFormField(
                  controller: businessemailCtrl,
                  readOnly: true,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 25.0, right: 20, left: 20),
              child: Text(
                'Company Location: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
