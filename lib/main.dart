import 'package:flutter/material.dart';
import 'package:kop_spse/providers/user.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/screens/home_screen.dart';
import 'package:kop_spse/screens/login_screen.dart';
import 'package:kop_spse/screens/second_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EduPageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigationKey,
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
          '/login2': (ctx) => const SecondLoginScreen(),
        },
      ),
    );
  }
}
