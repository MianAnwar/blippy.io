import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/DataModels/SearchReviewed.dart';
import 'package:total_app/APIs/GettingData.dart';
import 'package:total_app/UI/B4_Review/BusinessProductDetail.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ReviewScreen extends StatefulWidget {
  final String companycode;
  ReviewScreen({Key key, this.companycode}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<SearchReviewed> beingReviewed = List<SearchReviewed>();
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
    beingReviewed = await GettingData.flaggedProducts(widget.companycode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (beingReviewed.length == 0) {
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
            "Flagged For Review",
            style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20.0),
              child: Text('Submit All'),
            ),
            IconButton(
              onPressed: () {
                //////////////////////////////////
                //////////////////////////////////
                var alterDialog = AlertDialog(
                  title: Text('Are you sure to submit All?'),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        //YES%
                        setState(() {
                          this.deleting = true;
                        });
                        Navigator.of(context).pop();
                        for (int i = 0; i < beingReviewed.length; i++) {
                          //
                          print(1);
                          await GettingData.updateSubmitFlagged(
                              widget.companycode, beingReviewed[i].did);
                        }
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
                //////////////////////////////////
                //////////////////////////////////
              },
              icon: Icon(Icons.done_all_outlined),
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
                      child: CardList(beingReviewed[index]),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                // alignment: Alignment.topCenter,
                                color: Colors.white12,
                                height: 175,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        /////
                                        print(beingReviewed[index].did);

                                        /*
                                        Now First Get the product object
                                        and pass towards next View Screen
                                        */

                                        // print(beingReviewed[index].title);
                                        // Navigator
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    BusinessProductDetail(
                                                      cc: widget.companycode,
                                                      did: beingReviewed[index]
                                                          .did,
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.open_in_new),
                                        title: Text('Open and Review'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //Are you sure to submit
                                        var alterDialog = AlertDialog(
                                          title: Text(
                                              'Are you sure to submit/Remove from Flagged List?\n\n ${beingReviewed[index].title}'),
                                          actions: [
                                            FlatButton(
                                              onPressed: () async {
                                                //YES%
                                                setState(() {
                                                  this.deleting = true;
                                                });
                                                Navigator.of(context).pop();
                                                await GettingData
                                                    .updateSubmitFlagged(
                                                        widget.companycode,
                                                        beingReviewed[index]
                                                            .did);
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
                                        leading: Icon(Icons.done),
                                        title: Text('Submit'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // //Are you sure to delete
                                        var alterDialog = AlertDialog(
                                          title: Text(
                                              'Are you sure to Delete? \n\n${beingReviewed[index].title}'),
                                          actions: [
                                            FlatButton(
                                              onPressed: () async {
                                                //YES%
                                                setState(() {
                                                  this.deleting = true;
                                                });
                                                Navigator.of(context).pop();
                                                await GettingData.deleteProduct(
                                                    widget.companycode,
                                                    beingReviewed[index].did);
                                                Navigator.of(context).pop();
                                                refresh();
                                                //
                                                setState(() {
                                                  this.deleting = false;
                                                });
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
                  itemCount: beingReviewed.length,
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
  final SearchReviewed data;

  CardList(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        child: Container(
          // color: Colors.white24,
          padding: EdgeInsets.all(4.0),

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
                                    Icon(
                                      Icons.flag_outlined,
                                      size: 15.0,
                                    ),
                                    Text(
                                      " Flag ",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(' by ${data.flaggedBy}'),
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
                                        Icons.flag_outlined,
                                        size: 15.0,
                                      ),
                                      Text(
                                        " Reason ",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              ' due to ${data.flaggedReason}',
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
