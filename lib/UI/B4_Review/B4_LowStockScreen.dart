import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/SearchLowStock.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/UI/B4_Review/BProductDetails.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LowStockScreen extends StatefulWidget {
  final String companycode;
  LowStockScreen({Key key, this.companycode}) : super(key: key);

  @override
  _LowStockScreenState createState() => _LowStockScreenState();
}

class _LowStockScreenState extends State<LowStockScreen> {
  List<SearchLowStock> lowStockResult = List<SearchLowStock>();

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
    return Scaffold(
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
                                      title: Text('Add Stock'),
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
    );
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
