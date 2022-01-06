import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';

class MapScreen extends StatelessWidget {
  static String route = "/homeScreen";
  const MapScreen({Key? key}) : super(key: key);

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
      drawer: const CustomDrawer(),
      body: SvgPicture.asset(
        'assets/images/HB00.svg',
        height: 600,
        fit: BoxFit.cover,
        semanticsLabel: 'mapa skoly',
      ),
    );
  }
}
