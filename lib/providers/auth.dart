import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'edupage.dart';

class AuthProvider with ChangeNotifier {
  late final String _uid;
  late final String _email;
  late final String _password;

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

  String _currentLang = 'SVK';
  String get getCurrentLang => _currentLang;
  set setLang(String x) {
    _currentLang = x;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<bool> _firebaseRegisterEmail(String email, String password) async {
    bool uspesne = false;
    try {
      final userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userData.user!.uid);
      _uid = userData.user!.uid;
      _email = userData.user!.email!;
      uspesne = true;
    } catch (e) {
      print(e);
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
      print(e);
    }
    return uspesne;
  }

  Future<void> createDataAfterReg(
      String eduUser, String eduPass, String lang) async {
    if (!await firestoreDocExists())
      await _firestore.collection('users').doc(getUID).set({
        'eduUsername': eduUser,
        'eduPassword': eduPass,
        'email': _email,
        'language': lang,
      });
    print('created data');
  }

  Future<void> login({
    required EduPageProvider eduProvider,
    required String email,
    required String password,
  }) async {
    _loggedIn = await _firebaseLoginEmail(email, password);
    CollectionReference users = _firestore.collection('users');

    final DocumentSnapshot docSnap = await users.doc(getUID.toString()).get();
    final Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;

    print(docSnap);

    eduProvider.setAuthValues(
      data['eduUsername'],
      data['eduPassword'],
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
    _loggedIn = await _firebaseRegisterEmail(getEmail, getPassword);

    eduProvider.setAuthValues(eduUser, eduPassword);
    await eduProvider.login().then(
      (_) {
        if (eduProvider.getEduLoginStatus == LoginStatus.LoginFailed) return;
      },
    );

    await createDataAfterReg(eduUser, eduPassword, lang);

    eduProvider.setAuthValues(
      eduUser,
      eduPassword,
    );
    if (eduProvider.getEduLoginStatus != LoginStatus.LoggedIn)
      await eduProvider.login();
  }

  Future<void> LoginOrRegisterGoogle() async {
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

    if (userData.additionalUserInfo!.isNewUser) {
      print('New User');

      _uid = userData.user!.uid;
      _email = userData.user!.email as String;
    }

    return;
  }
}
