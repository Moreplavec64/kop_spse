import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:kop_spse/widgets/map_screen_widgets/mapCustomPaiter.dart';
import 'package:kop_spse/widgets/map_screen_widgets/navigation_search_widget.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 9 / 10,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InteractiveViewer(
              child: SizedBox(
                width: 210,
                height: 297,
                child: Consumer<MapProvider>(
                  builder: (ctx, prov, _) {
                    return CustomPaint(
                      foregroundPainter: MapCustomLinePainter(prov),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/map_images/${prov.getZobrazenePodlazie}.svg',
                            fit: BoxFit.fitWidth,
                            semanticsLabel: 'mapa skoly',
                          ),
                          SvgPicture.asset(
                            'assets/images/map_nazvy_overlays/${prov.getZobrazenePodlazie}_nazvy.svg',
                            fit: BoxFit.fitWidth,
                            semanticsLabel: 'mapa skoly',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: size.width * .15),
                child: NavigationSearchWidget()),
            TextButton(
                onPressed: () {
                  final x = Provider.of<MapProvider>(context, listen: false);
                  x.createRoute(x.getOdkial, x.getKam);
                },
                child: Text('Test ALG')),
          ],
        ),
      ),
    );
  }

  void testAllRoutes() {
    List<dynamic> route;
    //Najdene : 43056
    int najdene = 0;
    int nenajdene = 0;

    for (String z in edges.keys) {
      for (String ciel in edges.keys) {
        if (z == ciel) continue;
        route = (Dijkstra.findPathFromGraph(edges, z, ciel));
        if (route.isEmpty) {
          nenajdene++;
          print('Nenasla sa route z $z do $ciel');
        } else
          najdene++;
      }
    }
    print('Najdene : $najdene');
    print('Nenajdene : $nenajdene');
  }
}
