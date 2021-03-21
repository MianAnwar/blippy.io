// BProducts
import 'dart:async';
import 'package:total_app/DataModels/SearchResult.dart';
import 'package:flutter/material.dart';
import 'package:total_app/UI/B4_Review/BusinessProductDetail.dart';

import 'package:shimmer/shimmer.dart';

class BProducts extends StatefulWidget {
  final String comapanycode;
  final List<SearchResult> results;
  BProducts({this.results, @required this.comapanycode});

  @override
  _BProductsState createState() => _BProductsState();
}

class _BProductsState extends State<BProducts> {
  bool loadImage = true;
  bool colorIconCard = false;
  bool chosseCard = false;
  bool colorIconCard2 = true;

  var loadImageAnimation;

  var imageLoaded;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      setState(() {
        loadImage = false;
      });
    });
    loadImageAnimation = Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return cardLoading(widget.results[index]);
        },
        itemCount: widget.results.length,
      ),
    );
    ////////////////////////////////////////
    imageLoaded = Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (ctx, index) =>
              CardList(widget.results[index], widget.comapanycode),
          itemCount: widget.results.length,
        ));
    // TODo implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          chosseCard
              ? Padding(
                  padding: EdgeInsets.only(top: 95.0),
                  child: Container(
                    color: Colors.white,
                    child: loadImage
                        ? loadImageAnimation
                        : CardGrid(
                            data: widget.results,
                          ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 95.0),
                  child: Container(
                      color: Colors.white,
                      child: loadImage ? loadImageAnimation : imageLoaded),
                ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              color: Colors.white,
              height: 130.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 35.0, left: 15.0),
                          child: Icon(
                            Icons.clear,
                            size: 30.0,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Looking for Products",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (colorIconCard == true) {
                                      colorIconCard = false;
                                      colorIconCard2 = true;
                                      chosseCard = false;
                                    } else {
                                      colorIconCard = true;
                                      colorIconCard2 = false;
                                      chosseCard = true;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.calendar_view_day,
                                  color: colorIconCard
                                      ? Colors.black12
                                      : Colors.deepPurpleAccent,
                                )),
                            SizedBox(
                              width: 14.0,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (colorIconCard2 == true) {
                                      colorIconCard2 = false;
                                      colorIconCard = true;
                                      chosseCard = true;
                                    } else {
                                      colorIconCard2 = true;
                                      colorIconCard = false;
                                      chosseCard = false;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.sort,
                                  color: colorIconCard2
                                      ? Colors.black12
                                      : Colors.deepPurpleAccent,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardGrid extends StatelessWidget {
  final data;
  const CardGrid({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      childAspectRatio: mediaQueryData.size.height / 1100,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      primary: false,
      children: List.generate(
        /// Get data in flashSaleItem.dart (ListItem folder)
        data.length,
        (index) => ItemGrid(data[index]),
      ),
    );
  }
}

/// Component Card item in gridView after done loading image
class ItemGrid extends StatelessWidget {
  SearchResult data;
  ItemGrid(this.data);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                //
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      spreadRadius: 0.2,
                      blurRadius: 0.5)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: "hero-flashsale-${data.did}",
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return new Material(
                                    color: Colors.black54,
                                    child: Container(
                                      padding: EdgeInsets.all(30.0),
                                      child: InkWell(
                                        child: Hero(
                                            tag: "hero-flashsale-${data.did}",
                                            child: data.imageURL == ''
                                                ? Image.asset(
                                                    'assets/image/icon/box.png',
                                                    width: 300.0,
                                                    height: 400.0,
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.network(
                                                    data.imageURL,
                                                    width: 300.0,
                                                    height: 400.0,
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.contain,
                                                  )),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                transitionDuration:
                                    Duration(milliseconds: 500)));
                          },
                          child: SizedBox(
                            child: data.imageURL == ''
                                ? Image.asset(
                                    'assets/image/icon/box.png',
                                    fit: BoxFit.cover,
                                    height: 140.0,
                                    width: mediaQueryData.size.width / 2.1,
                                  )
                                : Image.network(
                                    data.imageURL,
                                    fit: BoxFit.cover,
                                    height: 140.0,
                                    width: mediaQueryData.size.width / 2.1,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                      child: Container(
                        width: mediaQueryData.size.width / 2.7,
                        child: Text(
                          data.title,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sofia"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text("\$" + data.salePrice,
                          style: TextStyle(
                              fontSize: 15.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

////////////
class CardList extends StatelessWidget {
  final _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 19.0,
    fontWeight: FontWeight.w800,
  );

  final SearchResult data;
  final String cc;

  CardList(this.data, this.cc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //
        print(data.did);
        print(cc);

        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => BusinessProductDetail(
                  cc: cc,
                  did: data.did,
                )));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Container(
          height: 250.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(
            children: [
              Container(
                height: 165.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0)),
                  image: DecorationImage(
                      image: data.imageURL == ''
                          ? AssetImage('assets/image/icon/box.png')
                          : NetworkImage(data.imageURL),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 10.0),
                ),
                alignment: Alignment.topRight,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 220.0,
                            child: Text(
                              '${data.title}',
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        // Padding(padding: EdgeInsets.only(top: 5.0)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Text(
                            "\$" + data.salePrice,
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Gotik"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
//
class cardLoading extends StatelessWidget {
  SearchResult data;
  cardLoading(this.data);
  final color = Colors.black38;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0)
            ]),
        child: Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 220.0,
                          height: 25.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Container(
                          height: 15.0,
                          width: 100.0,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.9),
                          child: Container(
                            height: 12.0,
                            width: 140.0,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Container(
                          height: 10.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
