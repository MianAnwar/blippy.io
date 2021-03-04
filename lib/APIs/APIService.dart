import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:total_app/DataModels/ProfileModel.dart';

class APIServices {
  //
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

  //updateRegisteredUserName
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
