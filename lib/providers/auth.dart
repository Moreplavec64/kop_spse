import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kop_spse/utils/encrypt.dart';

import 'edupage.dart';

class AuthProvider with ChangeNotifier {
  late String _uid;
  late String _email;
  late String _password;

  String get getUID => _uid;
  String get getEmail => _email;
  String get getPassword => _password;

  void setEmailAndPass(String email, String password) {
    _email = email;
    _password = password;
  }

  bool _isLoggingIn = true;
  void toggleIsLoggingIn() {
    _isLoggingIn = !_isLoggingIn;
    notifyListeners();
  }

  bool get getLoggingIn => _isLoggingIn;

  bool _udajeZhodne = false;
  void toggleUdajeZhodne() {
    _udajeZhodne = !_udajeZhodne;
    notifyListeners();
  }

  bool get getUdajeZhodne => _udajeZhodne;

  bool _loggedIn = false;
  bool get getLoggedIn => _loggedIn;
  set setLoggedIn(bool l) => _loggedIn = l;

  String _currentLang = 'SVK';
  String get getCurrentLang => _currentLang;
  set setLang(String x) {
    _currentLang = x;
    notifyListeners();
  }

  bool authentificatedGoogle = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get getCurrentUser => _auth.currentUser;

  bool isGoogleUser() {
    User? currUser = _auth.currentUser;
    List<UserInfo> provData = currUser!.providerData;
    if (provData.length < 1) return false;
    return provData.first.providerId == 'google.com';
  }

  Future<bool> firestoreDocExists() async {
    bool _exist = false;
    try {
      await _firestore.collection('users').doc(getUID).get().then((doc) {
        _exist = doc.exists;
      });
      return _exist;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String password) async {
    //Create an instance of the current user.
    User? user = _auth.currentUser;
    bool rv = false;

    //Pass in the password to updatePassword.
    await user!.updatePassword(password).then((_) {
      print("Successfully changed password");
      rv = true;
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });

    return rv;
  }

  Future<bool> changeEduPass(String password) async {
    bool rv = false;
    await _firestore
        .collection('users')
        .doc(getUID)
        .update({
          'eduPassword': password,
        })
        .then((value) => rv = true)
        .onError((error, stackTrace) {
          print(error.toString());
          rv = false;
          return false;
        });
    return rv;
  }

  Future<bool> _firebaseRegisterEmail(String email, String password) async {
    bool uspesne = false;
    try {
      final userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uid = userData.user!.uid;
      _email = userData.user!.email!;
      uspesne = true;
    } catch (e) {
      print('ERROR: $e');
    }
    return uspesne;
  }

  Future<bool> _firebaseLoginEmail(String email, String password) async {
    bool uspesne = false;
    try {
      final userData = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uid = userData.user!.uid;
      _email = userData.user!.email!;
      uspesne = true;
    } catch (e) {
      print('ERROR: $e');
    }
    return uspesne;
  }

  Future<void> createDataAfterReg(
    String eduUser,
    String eduPass,
    String lang,
  ) async {
    final String key = getUID.padRight(32, 'x');
    eduPass = EncryptData.encryptAES(eduPass, key);
    if (!await firestoreDocExists())
      await _firestore.collection('users').doc(getUID).set({
        'eduUsername': eduUser,
        'eduPassword': eduPass,
        'email': _email,
        'language': lang,
      });
  }

  Future<void> login({
    required EduPageProvider eduProvider,
    required String email,
    required String password,
  }) async {
    _loggedIn = await _firebaseLoginEmail(email, password);
    if (!_loggedIn) {
      eduProvider.setLoginStatus = LoginStatus.LoginFailed;
      return;
    }
    CollectionReference users = _firestore.collection('users');

    final DocumentSnapshot docSnap = await users.doc(getUID).get();
    final Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;

    eduProvider.setDecryptAuthValues(
      data['eduUsername'],
      data['eduPassword'],
      getUID.padRight(32, 'x'),
    );
    if (eduProvider.getEduLoginStatus != LoginStatus.LoggedIn)
      await eduProvider.login();
  }

  Future<void> register({
    required EduPageProvider eduProvider,
    required String eduUser,
    required String eduPassword,
    required String lang,
  }) async {
    if (authentificatedGoogle)
      _loggedIn = true;
    else
      _loggedIn = await _firebaseRegisterEmail(getEmail, getPassword);

    eduProvider.setAuthValues(eduUser, eduPassword);
    await eduProvider.login().then((_) {
      if (eduProvider.getEduLoginStatus == LoginStatus.LoginFailed) return;
    });

    await createDataAfterReg(eduUser, eduPassword, lang);

    if (eduProvider.getEduLoginStatus != LoginStatus.LoggedIn)
      await eduProvider.login();
  }

  Future<bool> continueWithGoogle(
      {required EduPageProvider eduProvider}) async {
    // login through google
    // open dialog with google accounts
    final authUser = await GoogleSignIn().signIn();

    if (authUser == null) throw NullThrownError();

    final googleAuth = await authUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userData = await _auth.signInWithCredential(credential);
    print(userData.additionalUserInfo);
    print(userData.user);

    _uid = userData.user!.uid;
    _email = userData.user!.email as String;
    //if not new user, fetch data a potom push home
    if (!userData.additionalUserInfo!.isNewUser) {
      CollectionReference users = _firestore.collection('users');

      final DocumentSnapshot docSnap = await users.doc(getUID).get();
      final Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;

      eduProvider.setDecryptAuthValues(
        data['eduUsername'],
        data['eduPassword'],
        getUID.padRight(32, 'x'),
      );
      if (eduProvider.getEduLoginStatus != LoginStatus.LoggedIn)
        await eduProvider.login();
    }

    authentificatedGoogle = true;
    return userData.additionalUserInfo!.isNewUser;
  }
}
