import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/ReportModel.dart';
import 'package:total_app/APIs/GettingData.dart';

class ReportScreen extends StatefulWidget {
  final String companycode;
  ReportScreen({Key key, this.companycode}) : super(key: key);

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  List<ReportModel> reports = List<ReportModel>();

  @override
  void initState() {
    // TOD implement initState
    // get the list of products having field flagged!!
    super.initState();
    refresh();
  }

  refresh() async {
    //
    reports = await GettingData.getAllReports(widget.companycode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (reports.length == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Hero(
            tag: 'iconImage',
            child: Image.asset(
              'assets/empty.png',
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
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
          "Reports",
          style: TextStyle(
            fontFamily: "Sofia",
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          )
        ],
      ),

      // body
      body: Stack(
        children: <Widget>[
          // Title + Icon,     Products for Review

          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return InkWell(
                    child: CardList(reports[index]),
                  );
                },
                itemCount: reports.length,
              ),
            ),
          ),

          //
        ],
      ),
    );
  }
}

////////////
class CardList extends StatelessWidget {
  final ReportModel data;

  CardList(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(bottom: 10.0),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      color: Colors.grey[400],
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 15.0,
                            ),
                            Text(
                              " Date ",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(' ${data.date}'),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.grey[400],
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attractions,
                                size: 15.0,
                              ),
                              Text(
                                " Action ",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      ' ${data.action}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Name: ${data.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Email: ${data.email}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Colors.grey[400],
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    " Action ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ' ${data.action}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
