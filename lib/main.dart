import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/screens/home_screen.dart';
import 'package:kop_spse/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EduPageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Sen',
          primaryColor: Color.fromRGBO(3, 192, 60, 1),
          // primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (ctx) => const LoginScreen(),
          '/home': (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
//EduPage e = EduPage('spojenaskolanz', 'AdamHadar', '5RDVUDPSPA');