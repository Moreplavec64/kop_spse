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
            TextButton(
              onPressed: () => showSearch(
                context: context,
                delegate: Vyhladavanie(true),
              ),
              child:
                  Text('Odkial ' + Provider.of<MapProvider>(context).getOdkial),
            ),
            TextButton(
                onPressed: () => showSearch(
                      context: context,
                      delegate: Vyhladavanie(false),
                    ),
                child: Text('Kam ' + Provider.of<MapProvider>(context).getKam)),
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

List<String> generateUcebne() {
  final List<String> x = [];
  for (String podlazie in suradniceUcebni.keys) {
    x.addAll(suradniceUcebni[podlazie]!.keys);
  }
  return x;
}

class Vyhladavanie extends SearchDelegate<String> {
  final List<String> recent = [];
  final List<String> ucebne = generateUcebne();
  final bool isOdkial;

  Vyhladavanie(this.isOdkial);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String tmpQuery = query.toUpperCase();
    final suggestions = query.isEmpty
        ? ucebne
        : ucebne.where((element) => element.contains(tmpQuery)).toList();
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final String ucebna = suggestions[index];
        return ListTile(
          leading: Icon(Icons.class_),
          onTap: () {
            final provider = Provider.of<MapProvider>(context, listen: false);
            isOdkial
                ? provider.setodkial(ucebne[index])
                : provider.setKam(ucebne[index]);
            Navigator.of(context).pop();
            showResults(context);
          },
          title: RichText(
            text: TextSpan(
              text: ucebna.substring(0, ucebna.indexOf(tmpQuery)),
              style: TextStyle(
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                  text: tmpQuery,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ucebna
                      .substring(ucebna.indexOf(tmpQuery) + tmpQuery.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
