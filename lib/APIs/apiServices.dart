import 'package:firebase_auth/firebase_auth.dart';

class APIServices {
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////< Login, Signup >///////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
  // sign-in
  Future<int> signIn({String email, String password}) async {
    try {
      // await _firebaseAuth.signInWithEmailAndPassword(
      //     email: email, password: password);
      // if (this._firebaseAuth.currentUser.emailVerified) return 0; //successfull
      return -1;
    } catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      }
      return 3;
    }
  }

  //
  // sign-out
  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
  }

  //
  // sign-up
  Future<void> signUp(
      {String email, String password, String userName, String mobileNo}) async {
    UserCredential uc;
    try {
      // uc = await _firebaseAuth.createUserWithEmailAndPassword(
      //     email: email, password: password);

      uc.user.sendEmailVerification();

      // return BUser(uc.user.uid, userName, email, 0);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // return BUser('', userName, email, 1);
      } else if (e.code == 'email-already-in-use') {
        // return BUser('', userName, email, 2);
      } else if (e.code == 'invalid-email') {
        // return BUser('', userName, email, 3);
      } else if (e.code == 'operation-not-allowed') {
        // return BUser('', userName, email, 4);
      }
      // return BUser('', userName, email, 5);
    }
  }

  //
  // sendPasswordResetEmail
  Future<int> sendPasswordResetEmail(String email) async {
    try {
      // await _firebaseAuth.sendPasswordResetEmail(email: email);
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

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////< Dashboard >///////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

  // getDashboardData
  // Name  ==> from Profile
  // CurrentBalance, Sale(Demand)Amount, WithdrawalableAmount ==> from Account of the required User
  Future<void> getDashboardData(String email) async {
    try {
      // await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 0;
    } catch (e) {
      //Not correct Email

    }
  }

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////< Profile >/////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

  // getProfile
  static Future<void> getProfile(String email) async {
    try {
      // final CollectionReference users =
      //     FirebaseFirestore.instance.collection('TestUsers');
      // final DocumentSnapshot doc = await users.doc(email).get();
      // if (doc.exists) {
      //   // print(doc.data()['username'].toString());
      //   String uname = doc.data()['username'].toString();
      //   return uname == '' ? 'NoName' : uname;
      // } else {
      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }

  //
  // updateProfile
  static Future<void> updateProfile(
    String email,
    /*ProfileDataModel updatedProfile*/
  ) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////< Account >/////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

  // getAccount
  //     CurrentBalance, Sale(Demand)Amount, WithdrawalableAmount
  static Future<void> getAccount(String email) async {
    try {
      // final CollectionReference users =
      //     FirebaseFirestore.instance.collection('TestUsers');
      // final DocumentSnapshot doc = await users.doc(email).get();
      // if (doc.exists) {
      //   // print(doc.data()['username'].toString());
      //   String uname = doc.data()['username'].toString();
      //   return uname == '' ? 'NoName' : uname;
      // } else {
      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }

  //
  // updateCurrentBalance
  static Future<void> updateCurrentBalance(
      String email, String addBalance, bool addSub) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

  //
  // updateSaleAmount
  static Future<void> updateSaleAmount(
      String email, String addSaleAmount, bool addSub) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

  //
  // updateWithdrawalableAmount
  static Future<void> updateWithdrawalableAmount(
      String email, String withdarwAmount, bool addSub) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

/////////////////////////////////////////////////
/////////////////////////////////////////////////
////////////////////< Sale >/////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

  //
  // addNewSale
  static int addNewSale(
    String email,
    /*SaleDataModel sale*/
  ) {
    try {
      // CollectionReference dealsss = getDealsssReference(cc);
      // dealsss.doc(newDealss).set({
      //   'DealsName': newDealss,
      // }).then((value) {
      //   return 1;
      // }).catchError((error) {
      //   return -1;
      // });
      return 1;
    } catch (ex) {
      return -1;
    }
  }

  //
  // updateSale
  static Future<void> updateSale(
    String email,
    /*SaleDataModel sale*/
  ) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

  //
  // updateSale
  static Future<void> deleteSale(
    String email,
    /*SaleDataModel sale pickid*/
  ) async {
    try {
      // CollectionReference user =
      //     FirebaseFirestore.instance.collection('RegisteredUsers');

      // final doc = await user.doc(email).get();
      // if (doc.exists) {
      //   doc.reference.update({'fullname': newUsername});
      //   return 0;
      // } else {
      //   return 1;
      // }
    } catch (e) {
      return -1;
    }
  }

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

}
