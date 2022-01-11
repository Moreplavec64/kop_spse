import 'package:flutter/material.dart';
import 'package:kop_spse/utils/map_constants.dart';

class MapProvider with ChangeNotifier {
  String zobrazenePodlazie = 'HBP0';
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
  }
}
