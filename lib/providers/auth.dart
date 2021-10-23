import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late final String _uid;
  late final String _email;

  String get getUID => _uid;
  String get getEmail => _email;

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> firestoreDocExists() async {
    bool _exist = false;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(getUID)
          .get()
          .then((doc) {
        _exist = doc.exists;
      });
      return _exist;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerEmail(String email, String password) async {
    bool uspesne = false;
    try {
      final userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uid = userData.user!.uid;
      _email = userData.user!.email!;
    } catch (e) {
      print(e);
    }
    return uspesne;
  }

  Future<bool> loginEmail(String email, String password) async {
    bool uspesne = false;
    try {
      final userData = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uid = userData.user!.uid;
      _email = userData.user!.email!;
    } catch (e) {
      print(e);
    }
    return uspesne;
  }

  Future<void> createDataAfterReg(String eduUser, String eduPass) async {
    if (!await firestoreDocExists())
      await FirebaseFirestore.instance.collection('users').doc(getUID).set({
        'eduUsername': eduUser,
        'eduPassword': eduPass,
        'email': getEmail,
        'language': 'SVK',
      });
  }
}
