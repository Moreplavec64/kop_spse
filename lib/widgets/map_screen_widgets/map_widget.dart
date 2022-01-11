import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/HB0P.svg',
          height: 291 * 2,
          fit: BoxFit.cover,
          semanticsLabel: 'mapa skoly',
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
    );
  }
}
