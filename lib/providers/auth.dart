import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late final String _uid;
  late final String _email;

  String get getUID => _uid;
  String get getEmail => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
