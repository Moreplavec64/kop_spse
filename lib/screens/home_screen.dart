import 'package:flutter/material.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/home_screen_widgets/timetable.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _size = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight);

    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          size: MediaQuery.of(context).size,
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            HomeScreenTimeTable(size: _size),
            Container(
              height: _size.height * (4 / 7),
              color: Colors.grey[200],
            ),
            Container(
              height: _size.height * (1 / 7),
              color: Colors.white,
            ),
          ],
        ));
  }
}
