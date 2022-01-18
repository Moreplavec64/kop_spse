import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:kop_spse/utils/map_constants.dart';

class MapProvider with ChangeNotifier {
  String _zobrazenePodlazie = 'HBP0';
  void setPoschodie(String podlazie) {
    if (_zobrazenePodlazie != podlazie) {
      _zobrazenePodlazie = podlazie;
      notifyListeners();
    }
  }

  String get getZobrazenePodlazie => _zobrazenePodlazie;

  List<String> _vyznacene = [];
  void setVyznacene(List<String> ucebne) {
    _vyznacene = [...ucebne];
    notifyListeners();
  }

  List<String> get getVyznacene => _vyznacene;

  String _odkial = 'D106';
  void setodkial(String ucebna) {
    _odkial = ucebna;
    notifyListeners();
  }

  String get getOdkial => _odkial;

  String _kam = 'C109';
  void setKam(String ucebna) {
    _kam = ucebna;
    notifyListeners();
  }

  String get getKam => _kam;

  List<String> shouldDisplayButtons = [
    'HBP0',
    'HBP1',
    'HBP2',
    '6AP0',
    '6AP1',
    '6BP0',
    '6BP1',
    '6CP0',
    '6CP1'
  ];

  Map<String, List<String>> routy = {
    'HBP0': [],
    'HBP1': [],
    'HBP2': [],
    '6AP0': [],
    '6AP1': [],
    '6BP0': [],
    '6BP1': [],
    '6CP0': [],
    '6CP1': [],
  };

  void createRoute(String z, String ciel) {
    //! po vyhladavani a vyznaceni convertovat
    //! ucebnu na destinacny a source waypoint*/
    setVyznacene([z, ciel]);
    List<dynamic> route = (Dijkstra.findPathFromGraph(
      edges,
      ucebnaToWaypoint[z] ?? z,
      ucebnaToWaypoint[ciel] ?? ciel,
    ));
    rozdelRouty(route);
    print(routy);
    //nastavenie zobrazeneho podlazia na to kde sa zacina routa
    setPoschodie(
      suradniceWaypointov.keys.firstWhere(
        (e) => suradniceWaypointov[e]!.containsKey(route.first),
      ),
    );
    // print(route);
    // testAllRoutes();
  }

  void rozdelRouty(List<dynamic> inputRoute) {
    var route = List<String>.from(inputRoute);
    for (String x in suradniceWaypointov.keys) {
      routy[x] = route
          .where((element) => suradniceWaypointov[x]!.containsKey(element))
          .toList();
    }
    notifyListeners();
  }
}
