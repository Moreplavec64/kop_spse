import 'package:flutter/material.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/home_screen_widgets/jedalen_widget.dart';
import 'package:kop_spse/widgets/home_screen_widgets/map_home_widget.dart';
import 'package:kop_spse/widgets/home_screen_widgets/timetable.dart';

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
        onDrawerChanged: (wasClosed) {
          //TODO sync lang data if changed
        },
        body: Column(
          children: [
            //height 2/7
            HomeScreenTimeTable(size: _size),
            //height 1/7 - 3/7
            JedalenHomeScreenWidget(size: _size),
            //fit rest
            MapHomeWidget(size: _size),
          ],
        ));
  }
}
