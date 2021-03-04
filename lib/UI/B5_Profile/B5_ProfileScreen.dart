import 'package:flutter/material.dart';
import 'package:total_app/APIs/LoginService.dart';
import 'package:total_app/UI/B2_Message/AppBar_ItemScreen/notificationAppbar.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/APIs/APIService.dart';
import 'ListProfile/TSSettingApp.dart';
import 'ListProfile/License.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/UI/IntroApps/SignningOptions.dart';
import 'package:total_app/UI/B5_Profile/ListProfile/ViewProfile.dart';
import 'package:total_app/UI/IntroApps/Login.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;
  ProfileScreen({Key key, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username;
  String companylogo;

  @override
  void initState() {
    // TO: implement initState
    setUSername();
    getCompanyLogo();
    super.initState();
  }

  setUSername() async {
    this.username =
        await APIServices.getRegisteredUserName(widget.profile.email);
    setState(() {});
  }

  getCompanyLogo() async {
    this.companylogo =
        await GettingData.getCompanyUserDPURL(widget.profile.email);
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
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        new ViewEditProfile(profile: widget.profile)));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${username ?? 'Test User'}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 8),
                    RaisedButton(
                      elevation: 10.0,
                      padding: EdgeInsets.all(5.0),
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new ViewEditProfile(profile: widget.profile)));
                      },
                      color: Colors.white,
                      child: Text("view And Edit Profile"),
                    ),
                  ],
                ),
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
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0).copyWith(right: 0),
            child: Text('Logout'),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              var alterDialog = AlertDialog(
                title: Text('Alert'),
                content: Text('Are you sure to logout?'),
                actions: [
                  FlatButton(
                    onPressed: () async {
                      //
                      // Get ready
                      AuthenticationService service =
                          AuthenticationService(Constants.firebaseAuth);

                      // get result if sucessfull or not
                      await service.signOut();
                      Constants.logoutEmailSP();

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new Login(),
                          transitionDuration: Duration(milliseconds: 0),
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
          )
        ],
        title: Text(
          "Settings",
          style: TextStyle(fontFamily: "Sofia", fontSize: 25.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //
            //
            // options hi options
            Column(
              children: <Widget>[
                buildItem(),
                SizedBox(
                  height: 20,
                ),
                // Plans
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new SignningOptions()));
                  },
                  child: Category(
                    txt: "Plan",
                    image: "assets/image/icon/box.png",
                    padding: 20.0,
                  ),
                ),

                // Notifications
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new NotificationAppbar()));
                  },
                  child: Category(
                    txt: "Notification",
                    image: "assets/image/icon/notification.png",
                    padding: 20.0,
                  ),
                ),

                //Settings
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new TSAppSetting()));
                  },
                  child: Category(
                    txt: "App Settings",
                    image: "assets/image/icon/settings.png",
                    padding: 20.0,
                  ),
                ),

                // About
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new LicensesSimplePage()));
                  },
                  child: Category(
                    txt: "About",
                    image: "assets/image/icon/italia.png",
                    padding: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Delete
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CategoryDEL(
                    txt: "Delete Account | Not Recoverable",
                    padding: 20.0,
                    tap: () {
                      String pwd = '';
                      var alterDialog = AlertDialog(
                        title: Column(
                          children: [
                            Text('Verify your Credentials'),
                            Text(
                                '\n${Constants.firebaseAuth.currentUser.email}'),
                          ],
                        ),
                        content: Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            onChanged: (p) {
                              pwd = p;
                              print(pwd);
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Your Password",
                              icon: Icon(Icons.vpn_key, color: Colors.black12),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontFamily: "sofia"),
                            ),
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              ////////////////////////////////////////

                              print(Constants.firebaseAuth.currentUser.email);
                              bool result = (await deleteAccount(
                                  Constants.firebaseAuth.currentUser.email,
                                  pwd));
                              if (result) {
                                // deleted
                                //pop, pop
                                print('deleted!');
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new Login(),
                                    transitionDuration:
                                        Duration(milliseconds: 0),
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
                              } else {
                                // Wrong credentials, try again
                                //just pop
                                print('Not deleted!');
                                Constants.showAlertDialogBox(
                                    context, 'Message', 'Not Deleted');
                                // Navigator.of(context).pop();
                              }

                              ////////////////////////////////////////
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteAccount(String email, String pwd) async {
    bool res = await APIServices.deleteAccount(email, pwd);
    return res;
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

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

// Component category class to set list
class CategoryDEL extends StatelessWidget {
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

  CategoryDEL({this.txt, this.image, this.tap, this.padding});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: tap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15, left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Icon(Icons.delete_forever_outlined)),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
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
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.black26,
                      size: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
