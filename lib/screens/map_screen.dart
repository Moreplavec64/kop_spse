import 'package:flutter/material.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/map_screen_widgets/map_widget.dart';
import 'package:kop_spse/widgets/map_screen_widgets/podlazie_button.dart';

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
      body: Stack(
        children: [
          MapWidget(),
          Column(
            children: [
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MapPodlazieButton(title: 'HB0', value: 'HBP0'),
                        MapPodlazieButton(title: 'HB1', value: 'HBP1'),
                        MapPodlazieButton(title: 'HB2', value: 'HBP2'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MapPodlazieButton(title: '6A0', value: '6AP0'),
                            MapPodlazieButton(title: '6A1', value: '6AP1'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MapPodlazieButton(title: '6B0', value: '6BP0'),
                            MapPodlazieButton(title: '6B1', value: '6BP1'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MapPodlazieButton(title: '6C0', value: '6CP0'),
                            MapPodlazieButton(title: '6C1', value: '6CP1'),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
