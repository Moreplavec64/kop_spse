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
    final mapProvider = Provider.of<MapProvider>(context);
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
                child: CustomPaint(
                  painter: MapCustomLinePaiter(mapProvider),
                  child: SvgPicture.asset(
                    'assets/images/${mapProvider.getZobrazenePodlazie}.svg',
                    fit: BoxFit.fitWidth,
                    semanticsLabel: 'mapa skoly',
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  List<dynamic> route = (Dijkstra.findPathFromGraph(
                      edges, 'D013-14/Riaditel', 'C108/C109'));
                  var x = Provider.of<MapProvider>(context, listen: false);
                  x.rozdelRouty(route);
                  print(x.routy);
                },
                child: Text('Test ALG')),
          ],
        ),
      ),
    );
  }
}

class MapCustomLinePaiter extends CustomPainter {
  final MapProvider provder;

  MapCustomLinePaiter(this.provder);

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
