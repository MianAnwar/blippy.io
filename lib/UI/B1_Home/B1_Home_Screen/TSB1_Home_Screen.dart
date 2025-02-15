import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'TSSearch.dart';
import 'package:total_app/constants.dart';
import 'package:badges/badges.dart';
import 'package:total_app/UI/B1_Home/B1_Home_Screen/TSeditProfile.dart';
import 'package:total_app/APIs/APIService.dart';

// TSHome
class TSHome extends StatefulWidget {
  final String email;

  TSHome({this.email});
  @override
  _TSHome createState() => _TSHome();
}

class _TSHome extends State<TSHome> {
  bool value = false;
  String username;

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Constants.basicColor.withOpacity(0.5),
    ));

    var _appBar = AppBar(
      backgroundColor: Constants.basicColor.withOpacity(0.5),
      title: Text(
        "Test Mode",
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
        // //Switcher
        Transform.scale(
          scale: 1,
          child: Switch(
            value: value,
            onChanged: (v) {
              setState(() {
                value = v;
              });
            },
          ),
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
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => new TSSearch(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        ),
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
                color: Constants.basicColor.withOpacity(0.5),
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: Constants.basicColor.withOpacity(0.5),
                      child: Center(
                        child: Hero(
                          tag: 'iconImage',
                          child: Image.asset(
                            'assets/logos.png',
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Row(
                        children: [
                          // user image
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      TSEditProfile(email: widget.email),
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
                                    image: AssetImage(
                                      "assets/image/icon/profile.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                  "${this.username ?? 'TestUser'}",
                                  overflow: TextOverflow.clip,
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
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _searchBox,
                          value ? regularUser() : ownerOptions(),
                        ],
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

  Widget ownerOptions() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expansion Tile

              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              color: Colors.white,
                              // height: 250,
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int i) {
                                    return ListTile(
                                      title: Text('Flagged Data item $i'),
                                    );
                                  }));
                        });
                  },
                  child: buildCardButton(
                      Icons.flag_outlined, "Flagged", true, 10)),

              SizedBox(width: 5),

              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              color: Colors.white,
                              // height: 250,
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int i) {
                                    return ListTile(
                                      title: Text(' Data $i'),
                                    );
                                  }));
                        });
                  },
                  child: buildCardButton(
                      Icons.account_tree, "Low Stock", true, 23)),
              SizedBox(width: 5),

              InkWell(
                  onTap: () {
                    ////Add NEw Item
                  },
                  child: buildCardButton(
                      Icons.breakfast_dining, "Items Add", true, 231)),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///////////////////
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            color: Colors.white,
                            // height: 250,
                            child: ListView.builder(
                                itemCount: 20,
                                itemBuilder: (BuildContext context, int i) {
                                  return ListTile(
                                    title: Text('Current sale And Promos $i'),
                                  );
                                }));
                      });
                },
                child: buildCardButton(
                    Icons.assignment_turned_in, "Current Sale", false, 0),
              ),
              SizedBox(width: 5),

              buildCardButton(Icons.star, "Featured", false, 0),
              SizedBox(width: 5),

              buildCardButton(Icons.fiber_new_sharp, "New", false, 0),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCardButton(Icons.report_problem, "Reports", false, 0),
              SizedBox(width: 5),
              buildCardButton(Icons.trending_up, "Trending", false, 0),
            ],
          ),
        ),
      ],
    );
  }

  Widget regularUser() {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                print("Clicked record..");
              },
              child: buildCardButton(
                  Icons.fiber_new_outlined, "New Item", true, 10),
            ),
            SizedBox(width: 40),
            InkWell(
              onTap: () {
                print("Clicked record..");
              },
              child: buildCardButton(
                  Icons.cloud_upload_outlined, "See & Update", true, 23),
            ),
          ],
        ),
      ),
      Divider(),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCardButton(Icons.report, "View Reports", false, 0),
          ],
        ),
      ),
      Divider()
    ]);
  }

  Card buildCardButton(var icons, String text, bool badge, int count) {
    return Card(
      child: Container(
        color: Colors.white10,
        height: 95,
        width: 110,
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
              color: Constants.basicColor.withOpacity(0.7),
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
