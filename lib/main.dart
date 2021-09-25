import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(
          create: (ctx) => EduPageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
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