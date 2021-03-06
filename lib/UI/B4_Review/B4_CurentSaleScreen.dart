import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/SaleResult.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';

class CurrentSaleScreen extends StatefulWidget {
  final String companycode;
  CurrentSaleScreen({Key key, this.companycode}) : super(key: key);

  @override
  _CurrentSaleScreenState createState() => _CurrentSaleScreenState();
}

class _CurrentSaleScreenState extends State<CurrentSaleScreen> {
  List<SaleResult> lowStockResult = List<SaleResult>();

  @override
  void initState() {
    // TOD implement initState
    // get the list of products having field flagged!!
    super.initState();
    refresh();
  }

  refresh() async {
    //
    lowStockResult = await GettingData.currentSales(widget.companycode);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (lowStockResult.length == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
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
          "Current Sales",
          style: TextStyle(
            fontFamily: "Sofia",
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              //////////////////////////////////
              //////////////////////////////////
              //////////////////////////////////
              //////////////////////////////////
              ProgressDialog dialog = ProgressDialog(context);
              await dialog.show();
              refresh();
              await dialog.hide();
            },
            icon: Icon(Icons.refresh),
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
                    child: CardList(lowStockResult[index]),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              // alignment: Alignment.topCenter,
                              color: Colors.white12,
                              height: 280,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.open_in_new),
                                      title: Text('Open'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      /////
                                      print(lowStockResult[index].did);
                                      // print(lowStockResult[index].title);
                                      // // Navigator
                                      // Navigator.of(context).push(
                                      //     PageRouteBuilder(
                                      //         pageBuilder: (_, __, ___) =>
                                      //             ProductDetails(
                                      //               did: lowStockResult[index]
                                      //                   .did,
                                      //             )));
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.open_in_browser),
                                      title: Text('Edit Sale'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.close),
                                      title: Text('Remove Sale'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.featured_play_list),
                                      title: Text('Mark Featured'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.delete_forever),
                                      title: Text('Delete Product'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  );
                },
                itemCount: lowStockResult.length,
              ),
            ),
          ),

          Divider(),

          //
        ],
      ),
    );
  }
}

////////////
class CardList extends StatelessWidget {
  final SaleResult data;

  CardList(this.data);

  @override
  Widget build(BuildContext context) {
    // print((DateTime.parse(data.endDate)));
    // IF LESS THEN 1
    // IF EQUAL 0
    // IF GREATER -1
    // print(DateTime.now().difference((DateTime.parse(data.endDate))).inDays);
    var what = DateTime.now().difference((DateTime.parse(data.endDate))).inDays;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          // color: Colors.amber,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        width: 100,
                        height: 100,
                        image: NetworkImage('${data.imageURL}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${data.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
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
                                    Text(
                                      " ${data.startDate} ",
                                      // style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.forward),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              color: Colors.grey[400],
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " ${data.endDate} ",
                                      // style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              color: what == 0
                                  ? Colors.amber
                                  : what == 1
                                      ? Colors.red
                                      : Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " ${what == 0 ? 'Last Day' : what == 1 ? 'Expired' : 'Active'} ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
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
        ),
      ),
    );
  }
}
