import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:kop_spse/widgets/map_screen_widgets/mapCustomPaiter.dart';
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
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  DropdownTlacitko(
                    initialDropdownValue: 'D106',
                    odkialKam: 'odkial',
                  ),
                  DropdownTlacitko(
                    initialDropdownValue: 'C109',
                    odkialKam: 'kam',
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  final x = Provider.of<MapProvider>(context, listen: false);
                  x.createRoute(x.odkial, x.kam);
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

class DropdownTlacitko extends StatefulWidget {
  final String initialDropdownValue;
  final String odkialKam;
  const DropdownTlacitko({
    Key? key,
    required this.initialDropdownValue,
    required this.odkialKam,
  }) : super(key: key);

  @override
  State<DropdownTlacitko> createState() => _DropdownTlacitkoState();
}

class _DropdownTlacitkoState extends State<DropdownTlacitko> {
  @override
  Widget build(BuildContext context) {
    final x = Provider.of<MapProvider>(context, listen: false);

    String dropdownValue = widget.odkialKam == 'kam' ? x.kam : x.odkial;
    List<String> values = [];
    for (String x in suradniceUcebni.keys) {
      values.addAll(suradniceUcebni[x]!.keys);
    }
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.odkialKam == 'kam' ? x.kam = newValue : x.odkial = newValue;
        });
      },
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
