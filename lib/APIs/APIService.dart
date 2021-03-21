import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/DataModels/BusinessModel.dart';

class APIServices {
/////////////
////
////
/////
/////////////
  // deleteAccount
  // first get the sign in
  // deleteBusinessAccountToo
  static Future<bool> deleteBusinessAccountToo(
      String email, String password, String cc) async {
    print('C1');
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    print('2');

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('3');

      await FirebaseAuth.instance.currentUser.delete();
      print('4');
      bool fg1 = await deleteBusiness(cc);
      bool fg2 = await deleteRegisteredInfo(email);
      print('5');

      return fg1 && fg2;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // print('The user must reauthenticate before this operation can be executed.');
      }
      return false;
    }
  }

  // delete Business
  static Future<bool> deleteBusiness(String cc) async {
    try {
      CollectionReference testUser =
          FirebaseFirestore.instance.collection('Companies');

      final doc = await testUser.doc(cc).get();
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

/*
/////////////
////
  ///
  ///
  ///
  ///
/////////////
*/
  // deleteAccount
  // first get the sign in
  //deleteRegistered
  static Future<bool> deleteOnlyDesignatedAccount(
      String email, String password) async {
    print('R1');
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    print('2');

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('3');

      await FirebaseAuth.instance.currentUser.delete();
      print('4');
      bool fg = await deleteRegisteredInfo(email);
      print('5');

      return fg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // print('The user must reauthenticate before this operation can be executed.');
      }
      return false;
    }
  }

  // delete Registered
  static Future<bool> deleteRegisteredInfo(String email) async {
    try {
      CollectionReference testUser =
          FirebaseFirestore.instance.collection('RegisteredUsers');

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

//
/*



*/

// deleteAccount
// first get the sign in
  static Future<bool> deleteTestUserAccount(
      String email, String password) async {
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

  // delete user
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

/*




*/
  // update TestUser username
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

  //updateRegisteredUserName
  static Future<int> updateRegisteredUserName(
      String newUsername, String email) async {
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection('RegisteredUsers');

      final doc = await user.doc(email).get();
      if (doc.exists) {
        doc.reference.update({'fullname': newUsername});
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  // updateRegisteredPhoneNumber
  static Future<int> updateRegisteredPhoneNumber(
      String newphoneNo, String email) async {
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection('RegisteredUsers');

      final doc = await user.doc(email).get();
      if (doc.exists) {
        doc.reference.update({'contactNo': newphoneNo});
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  // getTestUserName
  static Future<String> getTestUserName(String email) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('TestUsers');
      final DocumentSnapshot doc = await users.doc(email).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        String uname = doc.data()['username'].toString();
        return uname == '' ? 'NoName' : uname;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // getRegisteredUser
  static Future<Profile> getRegisteredUser(String email) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('RegisteredUsers');
      final DocumentSnapshot doc = await users.doc(email).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        return Profile.fromMapObj(doc.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

// getRegisteredUser
  static Future<Business> getBusiness(String cc) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('Companies');
      final DocumentSnapshot doc = await users.doc(cc).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        print(doc.data());
        return Business.fromMapObj(doc.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // getRegisteredUserName
  static Future<String> getRegisteredUserName(String email) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('RegisteredUsers');
      final DocumentSnapshot doc = await users.doc(email).get();
      if (doc.exists) {
        // print(doc.data()['username'].toString());
        String uname = doc.data()['fullname'].toString();
        return uname == '' ? 'NoName' : uname;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
