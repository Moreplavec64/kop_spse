import 'package:flutter/material.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/home_screen_widgets/timetable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

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
              child: TextButton(
                  onPressed: () async =>
                      await Provider.of<JedalenProvider>(context, listen: false)
                          .fetchJedalenData(),
                  child: Text('AAAAAAAAAA')),
            ),
            Container(
              height: _size.height * (1 / 7),
              color: Colors.white,
            ),
          ],
        ));
  }
}
