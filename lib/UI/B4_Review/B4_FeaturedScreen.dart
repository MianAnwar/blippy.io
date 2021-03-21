import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:total_app/UI/B4_Review/BusinessProductDetail.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FeaturedScreen extends StatefulWidget {
  final String companycode;
  FeaturedScreen({Key key, this.companycode}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  bool deleting = false;
  List<SearchResult> lowStockResult = List<SearchResult>();

  @override
  void initState() {
    // TOD implement initState
    // get the list of products having field flagged!!
    super.initState();
    refresh();
  }

  refresh() async {
    //
    lowStockResult = await GettingData.featuredProdcuts(widget.companycode);
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
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Hero(
            tag: 'iconImages',
            child: Image.asset(
              'assets/empty.png',
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
        ),
      );
    }
    return ModalProgressHUD(
      inAsyncCall: deleting,
      child: Scaffold(
        // AppBar
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Featured",
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
                                height: 170,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    BusinessProductDetail(
                                                      cc: widget.companycode,
                                                      did: lowStockResult[index]
                                                          .did,
                                                    )));
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
                                        var alterDialog = AlertDialog(
                                          title: Text(
                                              'Are you sure to Mark selected as Featured? \n\n${lowStockResult[index].title}'),
                                          actions: [
                                            FlatButton(
                                              onPressed: () async {
                                                setState(() {
                                                  this.deleting = true;
                                                });

                                                Navigator.of(context).pop();
                                                //YES%
                                                await GettingData
                                                    .updateMarkFeatured(
                                                        widget.companycode,
                                                        lowStockResult[index]
                                                            .did,
                                                        false);
                                                Navigator.of(context).pop();
                                                refresh();

                                                setState(() {
                                                  this.deleting = false;
                                                });
                                                //
                                              },
                                              child: Text("Yes"),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No"),
                                            )
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alterDialog;
                                            });
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons
                                            .signal_cellular_no_sim_rounded),
                                        title:
                                            Text('Remove from Featured List'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //
                                        var alterDialog = AlertDialog(
                                          title: Text(
                                              'Are you sure to Delete product item permanently? \n\n${lowStockResult[index].title}'),
                                          actions: [
                                            FlatButton(
                                              onPressed: () async {
                                                setState(() {
                                                  this.deleting = true;
                                                });
                                                //YES%
                                                Navigator.of(context).pop();
                                                await GettingData.deleteProduct(
                                                    widget.companycode,
                                                    lowStockResult[index].did);
                                                Navigator.of(context).pop();
                                                refresh();
                                                setState(() {
                                                  this.deleting = false;
                                                });
                                                //
                                              },
                                              child: Text("Yes - Delete"),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No"),
                                            )
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alterDialog;
                                            });
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
      ),
    );
  }
}

////////////
class CardList extends StatelessWidget {
  final SearchResult data;

  CardList(this.data);

  @override
  Widget build(BuildContext context) {
    // print((DateTime.parse(data.endDate)));
    // IF LESS THEN 1
    // IF EQUAL 0
    // IF GREATER -1
    // print(DateTime.now().difference((DateTime.parse(data.startDate))).inDays);
    var what =
        0; //= DateTime.now().difference((DateTime.parse(data.endDate))).inDays;

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
                        image: data.imageURL == ''
                            ? AssetImage('assets/image/icon/box.png')
                            : NetworkImage('${data.imageURL}'),
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
                              color: Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      " Featured ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                                        " ",
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Sale Price: \$${data.salePrice} ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                        " ",
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
