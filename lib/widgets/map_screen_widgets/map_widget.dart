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
    final mapprovider = Provider.of<MapProvider>(context, listen: false);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<String>(
              items: [
                ...List.generate(
                  mapprovider.routy.keys.length,
                  (index) {
                    final String value =
                        mapprovider.routy.keys.elementAt(index);
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: mapprovider.routy[value]!.isNotEmpty
                                ? Theme.of(context).primaryColor
                                : Colors.black),
                      ),
                    );
                  },
                ),
              ],
              onChanged: (value) => mapprovider.setPoschodie(value ?? ''),
              value: Provider.of<MapProvider>(context).getZobrazenePodlazie,
            ),
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
                          Hero(
                            tag: 'mapa',
                            child: SvgPicture.asset(
                              'assets/images/map_images/${prov.getZobrazenePodlazie}.svg',
                              fit: BoxFit.fitHeight,
                              semanticsLabel: 'mapa skoly',
                            ),
                          ),
                          if (prov.getZobrazNazvy)
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
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: size.height * .025),
              child: Tooltip(
                message: 'Vyhľadať trasu',
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    splashColor: Colors.white,
                    onTap: () {
                      // testAllRoutes();
                      mapprovider.setKamDefault = false;
                      mapprovider.setOdkialDefault = false;
                      mapprovider.createRoute(
                          mapprovider.getOdkial, mapprovider.getKam);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Vyhľadať',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 19 / 2,
                              ),
                              Icon(
                                Icons.search,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void testAllRoutes() {
    print(edges.keys.length);
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
