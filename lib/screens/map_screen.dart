import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:dijkstra/dijkstra.dart';
import 'dart:developer' as dev;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/HB00.svg',
                height: 600,
                fit: BoxFit.cover,
                semanticsLabel: 'mapa skoly',
              ),
              TextButton(
                  onPressed: () {
                    print(Dijkstra.findPathFromGraph(
                        edges, 'D013-14/Riaditel', 'C108/C109'));
                    dev.log([...edges.keys].toString());
                  },
                  child: Text('Test ALG')),
            ],
          ),
        ));
  }
}
