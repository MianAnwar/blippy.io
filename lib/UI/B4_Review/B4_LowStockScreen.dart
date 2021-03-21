import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/SearchLowStock.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/UI/B4_Review/BusinessProductDetail.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LowStockScreen extends StatefulWidget {
  final String companycode;
  LowStockScreen({Key key, this.companycode}) : super(key: key);

  @override
  _LowStockScreenState createState() => _LowStockScreenState();
}

class _LowStockScreenState extends State<LowStockScreen> {
  List<SearchLowStock> lowStockResult = List<SearchLowStock>();
  bool deleting = false;

  @override
  void initState() {
    // TOD implement initState
    // get the list of products having field flagged!!
    super.initState();
    refresh();
  }

  refresh() async {
    //
    lowStockResult = await GettingData.lowStockProducts(widget.companycode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (lowStockResult.length != 0) {
      return ModalProgressHUD(
        inAsyncCall: deleting,
        child: Scaffold(
          // AppBar
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Low Stock",
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
                                  height: 225,
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
                                                        did: lowStockResult[
                                                                index]
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
                                          int quantity = 0;
                                          /////
                                          print(lowStockResult[index].did);
                                          var alterDialog = AlertDialog(
                                            title: Text(
                                                'Update Stock! \n\nQuantity'),
                                            content: Container(
                                              height: 100,
                                              // color: Colors.green,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 1;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('1'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 2;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('2'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 3;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('3'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 5;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('5'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 9;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('9'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 12;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('12'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 14;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('14'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 16;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('16'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 20;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('20'),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            quantity = 30;
                                                          },
                                                          color: Colors.white60,
                                                          child: Text('30'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: () async {
                                                  //YES%
                                                  if (quantity != 0) {
                                                    setState(() {
                                                      this.deleting = true;
                                                    });
                                                    Navigator.of(context).pop();
                                                    await GettingData
                                                        .updateStock(
                                                            widget.companycode,
                                                            lowStockResult[
                                                                    index]
                                                                .did,
                                                            quantity);
                                                    Navigator.of(context).pop();
                                                    refresh();
                                                    setState(() {
                                                      this.deleting = false;
                                                    });
                                                  }
                                                },
                                                child: Text("Add Stock"),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              )
                                            ],
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alterDialog;
                                              });
                                          //
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.open_in_browser),
                                          title: Text('Add Stock'),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //
                                          var alterDialog = AlertDialog(
                                            title: Text(
                                                'Are you sure to Mark selected as Featured? \n\n${lowStockResult[index].title}'),
                                            actions: [
                                              FlatButton(
                                                onPressed: () async {
                                                  //YES%
                                                  setState(() {
                                                    this.deleting = true;
                                                  });
                                                  Navigator.of(context).pop();
                                                  await GettingData
                                                      .updateMarkFeatured(
                                                          widget.companycode,
                                                          lowStockResult[index]
                                                              .did,
                                                          true);
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
                                          leading:
                                              Icon(Icons.featured_play_list),
                                          title: Text('Mark Featured'),
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
                                                  await GettingData
                                                      .deleteProduct(
                                                          widget.companycode,
                                                          lowStockResult[index]
                                                              .did);
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
                                          leading: Icon(Icons.delete),
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
    } else {
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
  }

  Widget buildReviewItem(
      {String reason,
      String byWho,
      String productTitle,
      bool checked,
      String img}) {
    return null;
  }
}

////////////
class CardList extends StatelessWidget {
  final SearchLowStock data;

  CardList(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
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
                            color: Colors.grey[400],
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Text(
                                    " Stock ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          ' ${data.stock}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(' items remained'),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
