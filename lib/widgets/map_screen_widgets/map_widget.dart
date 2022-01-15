import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
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
                      foregroundPainter: MapCustomLinePaiter(prov),
                      child: SvgPicture.asset(
                        'assets/images/${prov.getZobrazenePodlazie}.svg',
                        fit: BoxFit.fitWidth,
                        semanticsLabel: 'mapa skoly',
                      ),
                    );
                  },
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  List<dynamic> route =
                      (Dijkstra.findPathFromGraph(edges, 'F106', 'F106'));
                  var x = Provider.of<MapProvider>(context, listen: false);
                  x.rozdelRouty(route);
                  // print(x.routy);
                  print(route);
                  // testAllRoutes();
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

class MapCustomLinePaiter extends CustomPainter {
  final MapProvider provider;
  MapCustomLinePaiter(this.provider);

  @override
  void paint(Canvas canvas, Size size) {
    final List<String> toDrawPath =
        provider.routy[provider.getZobrazenePodlazie] ?? [];
    final suradnicePrePodlazie =
        suradniceWaypointov[provider.getZobrazenePodlazie];
    final Paint paint = Paint()
      ..strokeWidth = 1
      ..color = Color.fromRGBO(3, 192, 60, 1);
    for (int i = 0; i < toDrawPath.length - 1; i++) {
      canvas.drawLine(suradnicePrePodlazie![toDrawPath[i]] ?? Offset(0, 0),
          suradnicePrePodlazie[toDrawPath[i + 1]] ?? Offset(0, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
