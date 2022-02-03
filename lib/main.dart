import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/providers/settings.dart';

import 'package:kop_spse/screens/fullscreen_map_screen.dart';
import 'package:kop_spse/screens/home_screen.dart';
import 'package:kop_spse/screens/login_screen.dart';
import 'package:kop_spse/screens/map_screen.dart';
import 'package:kop_spse/screens/menu_screen.dart';
import 'package:kop_spse/screens/second_login_screen.dart';
import 'package:kop_spse/screens/settings_screen.dart';

final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Directory directory = await pp.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('settings');
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
        ChangeNotifierProvider(create: (_) => JedalenProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider())
      ],
      child: MaterialApp(
        navigatorKey: navigationKey,
        title: 'SPSE App',
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
          '/settings': (ctx) => const SettingsScreen(),
          '/menu': (ctx) => const MenuScreen(),
          '/map': (ctx) => const MapScreen(),
          '/map/fullscreen': (ctx) => const FullscreenMapScreen(),
        },
      ),
    );
  }
}
