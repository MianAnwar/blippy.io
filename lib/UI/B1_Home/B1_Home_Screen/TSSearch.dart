import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';
import 'package:total_app/UI/B4_Review/TSProducts.dart';

class TSSearch extends StatefulWidget {
  @override
  _TSSearchState createState() => _TSSearchState();
}

class _TSSearchState extends State<TSSearch> {
  var _appBar = AppBar(
    iconTheme: IconThemeData(
      color: Color(0xFF56aeff),
    ),
    title: Text(
      "Search",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          color: Colors.black,
          fontFamily: "Gotik"),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0.0,
  );

  var _textHello = Padding(
    padding: EdgeInsets.only(right: 50.0, left: 20.0),
    child: Text(
      "Hello, \nWhat would you like to search ?",
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          fontSize: 27.0,
          color: Colors.black54,
          fontFamily: "Gotik"),
    ),
  );

  static final txtButton = TextStyle(
      color: Colors.black54, fontFamily: "Gotik", fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Caliing a variable
              _textHello,

              Padding(
                  padding:
                      const EdgeInsets.only(top: 65.0, right: 20.0, left: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ]),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Theme(
                              data: ThemeData(hintColor: Colors.transparent),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.search,
                                      color: Constants.basicColor,
                                      size: 28.0,
                                    ),
                                    hintText: "Find you want",
                                    hintStyle: txtButton),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: InkWell(
                          onTap: () {
                            //TSProducts()
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new TSProducts(),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Constants.basicColor,
                            ),
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
