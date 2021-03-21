import 'package:flutter/material.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/UI/IntroApps/PlanBSignup.dart';

class BStaffsScreen extends StatefulWidget {
  final Profile profile;
  BStaffsScreen({Key key, this.profile}) : super(key: key);

  @override
  _BStaffsScreenState createState() => _BStaffsScreenState();
}

class _BStaffsScreenState extends State<BStaffsScreen> {
  List<Profile> results = List<Profile>();

  @override
  void initState() {
    // TOD implement initState
    super.initState();
    refresh();
  }

  refresh() async {
    //
    this.results = await GettingData.getStaff(
        widget.profile.companycode, widget.profile.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (results.length == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => PlanBSignup(
                      companyCode: widget.profile.companycode,
                    )));
          },
          child: Center(
              child: Text(
            'Hire Staff\nNOW',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      );
    }
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Staff Memebers",
          style: TextStyle(
            fontFamily: "Sofia",
            fontWeight: FontWeight.w800,
            wordSpacing: 0.1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          ),
        ],
      ),

      // body
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            // alignment: Alignment.topCenter,
                            color: Colors.white12,
                            height: 120,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    //
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.change_history),
                                    title: Text('Change Role'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    //
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.close),
                                    title: Text('Fire-Delete'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: buildStaff(results[index]));
            },
            itemCount: results.length,
          ),
        ),
      ),
    );
  }

  Widget buildStaff(Profile s) {
    print(s.dpimageURL);
    return Container(
      // height: 200,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      // color: Colors.amber,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: s.dpimageURL == ''
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
                              image: NetworkImage(s.dpimageURL),
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
              padding: EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${s.fullname}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Email: ${s.email}",
                  ),
                  Text(
                    "Contact: ${s.contactNo}",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " ${s.role}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
