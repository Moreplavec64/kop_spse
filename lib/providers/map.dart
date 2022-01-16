import 'package:flutter/material.dart';
import 'package:kop_spse/utils/map_constants.dart';

class MapProvider with ChangeNotifier {
  String _zobrazenePodlazie = 'HBP0';
  void setPodlazie(String podlazie) {
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
