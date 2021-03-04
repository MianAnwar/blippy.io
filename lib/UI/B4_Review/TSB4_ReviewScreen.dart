import 'package:flutter/material.dart';
import 'package:total_app/constants.dart';

class TSReviewScreen extends StatefulWidget {
  TSReviewScreen({Key key}) : super(key: key);

  @override
  _TSReviewScreenState createState() => _TSReviewScreenState();
}

class _TSReviewScreenState extends State<TSReviewScreen> {
  //
  /// imageSlider in header layout category detail

  // Text _buildRatingStars(int rating) {
  //   String stars = '';
  //   for (int i = 0; i < rating; i++) {
  //     stars += '⭐ ';
  //   }
  //   stars.trim();
  //   return Text(stars);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            wordSpacing: 0.1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20.0),
            child: Text('Submit All'),
          ),
          IconButton(
            onPressed: () {
              Constants.showAlertDialogBox(
                  context, 'Alter Alert', 'Want to Submit All at once');
            },
            icon: Icon(Icons.done_all_outlined),
          )
        ],
      ),

      // body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title + Icon,     Products for Review
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Products for Review"),
                      // IconButton(
                      //     onPressed: () {
                      //       ////
                      //     },
                      //     icon: Icon(Icons.swap_calls)),
                    ])),

            Divider(),

            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        // alignment: Alignment.topCenter,
                        color: Colors.white12,
                        height: 150,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(Icons.open_in_browser),
                                title: Text('Open'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(Icons.done),
                                title: Text('Submit'),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: buildReviewItem(
                reason: 'Dimensions',
                byWho: 'Walter Jack',
                productTitle: 'Cell Phones',
                checked: false,
                img: 'assets/image/banner/banner3Travel.jpg',
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
    return Container(
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
                    image: AssetImage('$img'),
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
                    '$productTitle',
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
                      Text(' by $byWho'),
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
                          ' due to $reason',
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
    );
  }
}

// import 'package:total_app/constants.dart';
// import 'package:flutter/material.dart';

// class ReviewProduct {
//   String title;
//   bool value;
//   String img;
//   String bywho;
//   String reason;

//   ReviewProduct({
//     this.reason = "Location",
//     this.bywho = "Johns Walter",
//     this.title = "3D Sound Headphones",
//     this.img = 'assets/image/banner/banner3Travel.jpg',
//     this.value = false,
//   });
// }

// class TSReviewScreen extends StatefulWidget {
//   TSReviewScreen();

//   @override
//   _TSReviewScreenState createState() => _TSReviewScreenState();
// }

// class _TSReviewScreenState extends State<TSReviewScreen> {
//   final allowproductss = ReviewProduct(title: 'Select All');

//   final productss = [
//     ReviewProduct(title: '3D Sound Headphones'),
//     ReviewProduct(title: 'Cell Phones'),
//     ReviewProduct(title: 'Cellular Charger'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // AppBar
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.publish,
//               color: Constants.basicColor,
//             ),
//             onPressed: () {
//               //
//             },
//           ),
//         ],
//         title: Text(
//           "Flagged For Review",
//           style: TextStyle(
//             fontFamily: "Sofia",
//             fontWeight: FontWeight.w800,
//             wordSpacing: 0.1,
//           ),
//         ),
//       ),

//       body: ListView(
//         children: [
//           // Title + Icon,     Products for Review
//           Padding(
//               padding: EdgeInsets.only(left: 30.0, right: 20.0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Products for Review"),
//                     IconButton(
//                         onPressed: () {
//                           print('Popup');
//                         },
//                         icon: Icon(Icons.swap_calls)),
//                   ])),

//           Divider(),
//           ...productss.map(buildSingleCheckbox).toList(),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   label: Text("Submit"),
//       //   backgroundColor: Constants.basicColor,
//       //   onPressed: () {},
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Widget buildSingleCheckbox(ReviewProduct products) {
//     return buildCheckbox(
//       products: products,
//       onClicked: () {
//         setState(() {
//           final newValue = !products.value;
//           products.value = newValue;

//           if (!newValue) {
//             allowproductss.value = false;
//           } else {
//             final allow = productss.every((products) => products.value);
//             allowproductss.value = allow;
//           }
//         });
//       },
//     );
//   }

//   Widget buildCheckbox({
//     @required ReviewProduct products,
//     @required VoidCallback onClicked,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
//       // color: Colors.amber,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image(
//                     width: 95,
//                     height: 95,
//                     image: AssetImage('${products.img}'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     '${products.title}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: Container(
//                           color: Colors.grey[400],
//                           child: Padding(
//                             padding: EdgeInsets.all(3.0),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.flag_outlined,
//                                   size: 15.0,
//                                 ),
//                                 Text(
//                                   " Flag ",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(' by ${products.bywho}'),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20.0),
//                           child: Container(
//                             color: Colors.grey[400],
//                             child: Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.flag_outlined,
//                                     size: 15.0,
//                                   ),
//                                   Text(
//                                     " Reason ",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Text(
//                           ' due to ${products.reason}',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: onClicked,
//             child: Expanded(
//               flex: 1,
//               child: Checkbox(
//                 value: products.value,
//                 onChanged: (v) {
//                   onClicked();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
