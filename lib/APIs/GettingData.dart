import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:total_app/DataModels/productModel.dart';
import 'package:total_app/DataModels/SearchResult.dart';

class GettingData {
  ////
  static Future<List<SearchResult>> searchByBarcode(
      String cc, String barcode) async {
    //
    List<SearchResult> result = List<SearchResult>();
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Products');
    try {
      final QuerySnapshot snapshot = await ref.get();

      snapshot.docs.forEach((DocumentSnapshot doc) {
        String bar = doc.data()['barcode'];

        if (bar == barcode) {
          result.add(SearchResult.fromMapObj({
            'did': doc.id,
            'imageURL': doc.data()['imageURL'],
            'salePrice': doc.data()['salePrice'],
            'title': doc.data()['title'],
          }));
        }
      });
      return result;
    } catch (e) {
      return null;
    }
  }

  ///
  static Future<List<SearchResult>> searchPattern(
      String cc, String pattern) async {
    pattern = pattern.toLowerCase();
    //
    List<SearchResult> result = List<SearchResult>();
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Products');
    try {
      final QuerySnapshot snapshot = await ref.get();
      // print('$pattern 1');
      snapshot.docs.forEach((DocumentSnapshot doc) {
        String address = doc.data()['address'];
        String title = doc.data()['title'];
        String description = doc.data()['description'];
        String category = doc.data()['category'];
        String subCat = doc.data()['subCat'];
        String attributes = doc.data()['attributes'];

        if ((address.toLowerCase()).contains(pattern) ||
            (title.toLowerCase()).contains(pattern) ||
            (description.toLowerCase()).contains(pattern) ||
            (category.toLowerCase()).contains(pattern) ||
            (subCat.toLowerCase()).contains(pattern) ||
            (attributes.toLowerCase()).contains(pattern)) {
          // print('---------------');

          // print(doc);

          // print('---------------');
          // print(doc.data());
          // print('---------------');

          result.add(SearchResult.fromMapObj({
            'did': doc.id,
            'imageURL': doc.data()['imageURL'],
            'salePrice': doc.data()['salePrice'],
            'title': doc.data()['title'],
          }));
        }
      });
      return result;
    } catch (e) {
      return null;
    }
  }

//getCountOfProducts
  static Future<int> getCountOfProducts(String cc) async {
    int count = 0;
    try {
      CollectionReference company = FirebaseFirestore.instance
          .collection('Companies')
          .doc(cc)
          .collection('Products');
      final QuerySnapshot snapshot = await company.get();
      //
      snapshot.docs.forEach((DocumentSnapshot doc) {
        count += 1;
      });
      return count;
    } catch (e) {
      return -1;
    }
  }

//getCountOfProducts
  static Future<String> getBusinessName(String cc) async {
    try {
      CollectionReference comp =
          FirebaseFirestore.instance.collection('Companies');

      try {
        final DocumentSnapshot doc = await comp.doc(cc).get();
        if (doc.exists) {
          return (doc.data()['businessName']);
        } else {
          return '';
        }
      } catch (e) {
        return '-1';
      }
    } catch (e) {
      return '-1';
    }
  }

  //getCountOfProducts
  static Future<int> getCountOfStaff(String cc, String myEmail) async {
    int count = 0;
    try {
      CollectionReference staff =
          FirebaseFirestore.instance.collection('RegisteredUsers');
      final QuerySnapshot snapshot = await staff.get();
      //
      snapshot.docs.forEach((DocumentSnapshot doc) {
        if (doc.data()['companycode'] == cc) count += 1;
        if (doc.data()['email'] == myEmail) count -= 1;
      });
      return count;
    } catch (e) {
      return -1;
    }
  }

//getCountOfLowStock
  static Future<int> getCountOfLowStock(String cc) async {
    int xx = 0;
    int count = 0;
    try {
      CollectionReference company = FirebaseFirestore.instance
          .collection('Companies')
          .doc(cc)
          .collection('Products');
      final QuerySnapshot snapshot = await company.get();
      //
      snapshot.docs.forEach((DocumentSnapshot doc) {
        xx = int.parse(doc.data()['stock']);
        if (xx < 3) {
          count += 1;
        }
      });
      return count;
    } catch (e) {
      return -1;
    }
  }

  static Future<int> getCountOfFlagged(String cc) async {
    int count = 0;
    try {
      CollectionReference company = FirebaseFirestore.instance
          .collection('Companies')
          .doc(cc)
          .collection('Products');
      final QuerySnapshot snapshot = await company.get();
      //
      snapshot.docs.forEach((DocumentSnapshot doc) {
        if (doc.data()['flagged'] == 'YES') {
          count += 1;
        }
      });
      return count;
    } catch (e) {
      return -1;
    }
  }

  static Future<String> uploadImagetoFirebase(File imageFile) async {
    try {
      //
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'productImages/prod$randomNumber.jpg';
      // upload image to firebase
      await firebase_storage.FirebaseStorage.instance
          .ref(imageLocation)
          .putFile(imageFile);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('$imageLocation')
          .getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e.code);
      return '';
    } catch (e) {
      print(e.message);
      return '-1';
    }
  }

//checkProduct
  static Future<bool> checkProduct(Product pro, String cc) async {
    bool flag = false;
    try {
      CollectionReference company = FirebaseFirestore.instance
          .collection('Companies')
          .doc(cc)
          .collection('Products');
      final QuerySnapshot snapshot = await company.get();
      //
      snapshot.docs.forEach(
        (DocumentSnapshot doc) {
          if (doc.data()['title'] == pro.title) {
            flag = true;
            return true;
          }
          if (doc.data()['aisle'] == pro.aisle &&
              doc.data()['shelf'] == pro.shelf &&
              doc.data()['section'] == pro.section &&
              doc.data()['place'] == pro.place) {
            flag = true;
            return true;
          }
        },
      );
      //
      return flag;
    } catch (e) {
      return false;
    }
  }

  static int saveProduct(Product pro, String cc) {
    try {
      CollectionReference company = FirebaseFirestore.instance
          .collection('Companies')
          .doc(cc)
          .collection('Products');
      company.doc().set(pro.toMap()).then((value) {
        return 1;
      }).catchError((error) {
        return -1;
      });
      return 1;
    } catch (ex) {
      return -1;
    }
    ////////////
  }

  static CollectionReference getCategoriesReference(String cc) {
    return FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Categories');
  }

  static CollectionReference getSubCategoriesReference(String cc, String cat) {
    return FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Categories')
        .doc(cat)
        .collection('SubCat');
  }

  static Future<int> checkNewCategory(String newCat, String cc) async {
    final CollectionReference cat = FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Categories');
    try {
      final DocumentSnapshot doc = await cat.doc(newCat).get();
      if (doc.exists) {
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  static Future<int> checkNewSubCategory(
      String cat, String newSubCat, String cc) async {
    final CollectionReference subcatRef = FirebaseFirestore.instance
        .collection('Companies')
        .doc(cc)
        .collection('Categories')
        .doc(cat)
        .collection('SubCat');
    try {
      final DocumentSnapshot doc = await subcatRef.doc(newSubCat).get();
      if (doc.exists) {
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  static int saveNewCategory(String newCat, String cc) {
    try {
      CollectionReference category = getCategoriesReference(cc);
      category.doc(newCat).set({
        'CatName': newCat,
      }).then((value) {
        return 1;
      }).catchError((error) {
        return -1;
      });
      return 1;
    } catch (ex) {
      return -1;
    }
  }

  static int saveNewSubCategory(String cat, String newSubCat, String cc) {
    try {
      CollectionReference subCategory = getSubCategoriesReference(cc, cat);
      subCategory.doc(newSubCat).set({
        'SubCat': newSubCat,
      }).then((value) {
        return 1;
      }).catchError((error) {
        return -1;
      });
      return 1;
    } catch (ex) {
      return -1;
    }
  }

// deleteAccount
// first get the sign in
  static Future<bool> deleteAccount(String email, String password) async {
    print('1');
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    print('2');

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('3');

      await FirebaseAuth.instance.currentUser.delete();
      print('4');
      bool fg = await deleteTestUserInfo(email);
      print('5');

      return fg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // print('The user must reauthenticate before this operation can be executed.');
      }
      return false;
    }
  }

  // deleteUser
  static Future<bool> deleteTestUserInfo(String email) async {
    try {
      CollectionReference testUser =
          FirebaseFirestore.instance.collection('TestUsers');

      final doc = await testUser.doc(email).get();
      if (doc.exists) {
        doc.reference.delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // updateTestUser
  static Future<int> updateTestUser(String newUsername, String email) async {
    try {
      CollectionReference testUser =
          FirebaseFirestore.instance.collection('TestUsers');

      final doc = await testUser.doc(email).get();
      if (doc.exists) {
        doc.reference.update({'username': newUsername});
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  static Future<String> getCompanyMainImage(String cc) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('Companies');
      final DocumentSnapshot doc = await users.doc(cc).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        String imageURL = doc.data()['imageURL'].toString();
        return imageURL == '' ? 'assets/logo1.png' : imageURL;
      } else {
        return 'assets/logo1.png';
      }
    } catch (e) {
      return 'assets/logo1.png';
    }
  }

  static Future<String> getCompanyUserDPURL(String email) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('RegisteredUsers');
      final DocumentSnapshot doc = await users.doc(email).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        String imageURL = doc.data()['dpimageURL'].toString();
        return imageURL == '' ? 'assets/logo1.png' : imageURL;
      } else {
        return 'assets/logo1.png';
      }
    } catch (e) {
      return 'assets/logo1.png';
    }
  }
}
