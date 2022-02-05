import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/map_screen_widgets/map_button_column.dart';
import 'package:kop_spse/widgets/map_screen_widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _size = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight);

    return WillPopScope(
      onWillPop: () async {
        Provider.of<MapProvider>(context, listen: false).resetMapDefaults();
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          size: MediaQuery.of(context).size,
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            MapWidget(
              size: _size,
            ),
            Align(
              alignment: Alignment.topRight,
              child: MapIconButtonsColumn(),
            ),
          ],
        ),
      ),
    );
  }
}
