import 'package:flutter/material.dart';
import 'package:kop_spse/screens/home_screen.dart';
import 'package:kop_spse/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (ctx) => const LoginScreen(),
        '/home': (ctx) => const HomeScreen(),
      },
    );
  }
}
//EduPage e = EduPage('spojenaskolanz', 'AdamHadar', '5RDVUDPSPA');