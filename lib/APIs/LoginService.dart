import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:total_app/DataModels/User.dart';
import 'package:total_app/DataModels/ProfileModel.dart';
import 'package:total_app/DataModels/BusinessModel.dart';
import 'package:total_app/constants.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<int> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (this._firebaseAuth.currentUser.emailVerified) return 0; //successfull
      return -1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      }
      return 3;
    }
  }

/////////////
///////////////
  Future<Profile> createBussinessAccount({Profile profile, String pass}) async {
    UserCredential uc;
    try {
      uc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: profile.email, password: pass);

      uc.user.sendEmailVerification();

      return Profile(uc.user.uid, profile.fullname, profile.email, profile.role,
          profile.contactNo,
          retToken: 0);
      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Profile('', profile.fullname, profile.email, profile.role,
            profile.contactNo,
            retToken: 1);
      } else if (e.code == 'email-already-in-use') {
        return Profile('', profile.fullname, profile.email, profile.role,
            profile.contactNo,
            retToken: 2);
      } else if (e.code == 'invalid-email') {
        return Profile('', profile.fullname, profile.email, profile.role,
            profile.contactNo,
            retToken: 3);
      } else if (e.code == 'operation-not-allowed') {
        return Profile('', profile.fullname, profile.email, profile.role,
            profile.contactNo,
            retToken: 4);
      }
      return Profile(
          '', profile.fullname, profile.email, profile.role, profile.contactNo,
          retToken: 5);
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<BUser> signUp({String email, String password, String userName}) async {
    UserCredential uc;
    try {
      uc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      uc.user.sendEmailVerification();

      return BUser(uc.user.uid, userName, email, 0);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return BUser('', userName, email, 1);
      } else if (e.code == 'email-already-in-use') {
        return BUser('', userName, email, 2);
      } else if (e.code == 'invalid-email') {
        return BUser('', userName, email, 3);
      } else if (e.code == 'operation-not-allowed') {
        return BUser('', userName, email, 4);
      }
      return BUser('', userName, email, 5);
    }
  }

  Future<int> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 0;
    } on FirebaseAuthException catch (e) {
      //Not correct Email
      if (e.code == 'user-not-found') {
        // print('not found');
        return -1;
      } else if (e.code == 'invalid-email') {
        // print('invalid');
        return -2;
      }
      return -3;
    }
  }

  // registerStaffAccount
  Future<int> registerStaffAccount({Profile profile, String pass}) async {
    UserCredential uc;
    try {
      uc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: profile.email, password: pass);

      uc.user.sendEmailVerification();

      return 0;
      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      } else if (e.code == 'invalid-email') {
        return 3;
      } else if (e.code == 'operation-not-allowed') {
        return 4;
      }
      return 5;
    }
  }

//
//
//
////// get a particular document from TestUsers
  static Future<bool> checkEmailInTestUsers(String email) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('TestUsers');
    final DocumentSnapshot doc = await users.doc(email).get();
    if (doc.exists) {
      // print(doc.data()['username'].toString());
      // String uname = doc.data()['username'].toString();
      // return uname == '' ? 'NoName' : uname;
      return true;
    } else {
      return false;
    }
  }

////// get a particular document
  static Future<Profile> checkEmailinRegisteredUsers(String email) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('RegisteredUsers');

    final DocumentSnapshot doc = await users.doc(email).get();
    if (doc.exists) {
      return Profile.fromMapObj(doc.data());
    } else {
      return null;
    }
  }

  static int saveTestUser(BUser u) {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('TestUsers');
      users.doc(u.email).set(u.toMap()).then((value) {
        return 1;
      }).catchError((error) {
        return -1;
      });
      return 1;
    } catch (ex) {
      return -1;
    }
  }

  static int saveStaffUser(Profile p) {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('RegisteredUsers');
      users.doc(p.email).set(p.toMap()).then((value) {
        return 1;
      }).catchError((error) {
        return -1;
      });
      return 1;
    } catch (ex) {
      return -1;
    }
  }

  // getCountofStaff
  static Future<int> getCountofStaff(String key) async {
    try {
      CollectionReference companies =
          FirebaseFirestore.instance.collection(Constants.companies);

      final DocumentSnapshot doc = await companies.doc(key).get();
      if (doc.exists) {
        return (doc.data()['staffCount']);
      } else {
        return -2;
      }
    } catch (e) {
      return -1;
    }
  }

  // verify company exists or not
  static Future<int> verifyCompanyCode(String ccode) async {
    try {
      CollectionReference companies =
          FirebaseFirestore.instance.collection(Constants.companies);

      final DocumentSnapshot doc = await companies.doc(ccode).get();
      if (doc.exists) {
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  // -------------------------------
  // verify companyName exists or not
  // verify companyName exists or not
  static Future<bool> verifyCompanyName(String cname) async {
    bool flag = false;
    try {
      CollectionReference companies =
          FirebaseFirestore.instance.collection(Constants.companies);

      final QuerySnapshot snapshot = await companies.get();
      snapshot.docs.forEach(
        (DocumentSnapshot doc) {
          if (doc.data()['businessName'] == cname) {
            flag = true;
            return true;
          }
        },
      );
      return flag;
    } catch (e) {
      return false;
    }
  }

  static int registerNewCompany(Profile p, Business b) {
    // first save the owner information
    try {
      CollectionReference registeredUSers =
          FirebaseFirestore.instance.collection('RegisteredUsers');

      registeredUSers
          .doc(p.email)
          .set(p.toMap())
          .then((value) {})
          .catchError((error) {
        return -1;
      });

      // Second Store Company Informations
      CollectionReference companyInform = FirebaseFirestore.instance
          .collection(Constants.companies); // Companies :: Main Collection

      companyInform.doc(b.secretCode).set(b.toMap()).then(
        (value) {
          return 1; // Sucessfully saved
        },
      ).catchError((error) {
        return -1;
      });
      //if no exception occur then continue to return 1
      return 1;
    } catch (ex) {
      return -1;
    }
  }
}
