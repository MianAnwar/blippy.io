import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';

class NotificationAppbar extends StatefulWidget {
  NotificationAppbar({Key key}) : super(key: key);

  @override
  _NotificationAppbarState createState() => _NotificationAppbarState();
}

class _NotificationAppbarState extends State<NotificationAppbar> {
  bool flagged = true;
  bool lowStock = true;
  bool itemAddrd = false;
  bool salePromo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //
      appBar: AppBar(
        title: Text(
          "Push Notifications",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
              letterSpacing: 2.0,
              color: Colors.black54,
              fontFamily: "Berlin"),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      //
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Card(
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Flagged'),
              trailing: Transform.scale(
                scale: 1,
                child: Switch(
                  value: flagged,
                  onChanged: (value) {
                    setState(() {
                      this.flagged = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Low Stock'),
              trailing: Transform.scale(
                scale: 1,
                child: Switch(
                  value: lowStock,
                  onChanged: (value) {
                    setState(() {
                      this.lowStock = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Item Add'),
              trailing: Transform.scale(
                scale: 1,
                child: Switch(
                  value: itemAddrd,
                  onChanged: (value) {
                    setState(() {
                      this.itemAddrd = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.flag),
              title: Text('Sale/Promo'),
              trailing: Transform.scale(
                scale: 1,
                child: Switch(
                  value: salePromo,
                  onChanged: (value) {
                    setState(() {
                      this.salePromo = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
