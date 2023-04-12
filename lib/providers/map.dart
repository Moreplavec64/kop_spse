import 'package:dijkstra/dijkstra.dart';
import 'package:flutter/material.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapProvider with ChangeNotifier {
  //*Zobrazene podlazia
  String _zobrazenePodlazie = 'HBP0';
  void setPoschodie(String podlazie) {
    if (_zobrazenePodlazie != podlazie) {
      _zobrazenePodlazie = podlazie;
      notifyListeners();
    }
  }

  String get getZobrazenePodlazie => _zobrazenePodlazie;

  //*podlazia ktore sa maju vyznacit na mape
  List<String> _vyznacene = [];
  void setVyznacene(List<String> ucebne) {
    _vyznacene = [...ucebne];
    notifyListeners();
  }

  List<String> get getVyznacene => _vyznacene;

  //*Odkial sa zacina navigovat
  String _odkial = 'D106';
  void setodkial(String ucebna) {
    _odkial = ucebna;
    notifyListeners();
  }

  String get getOdkial => _odkial;
  //*boolean ci je v searchi odkial este defaultna hodnota
  bool _odkialDefault = true;
  bool get getOdkialDefault => _odkialDefault;
  set setOdkialDefault(x) {
    _odkialDefault = x;
    notifyListeners();
  }

  //*boolean ci je v searchi kam este defaultna hodnota
  bool _kamDefault = true;
  bool get getKamDefault => _kamDefault;
  set setKamDefault(x) {
    _kamDefault = x;
    notifyListeners();
  }

  //*Ciel navigacie
  String _kam = 'C109';
  void setKam(String ucebna) {
    _kam = ucebna;
    notifyListeners();
  }

  String get getKam => _kam;
//*Ciel navigacie
  bool _zobrazNazvy = false;
  void toggleZobrazNazvy() {
    _zobrazNazvy = !_zobrazNazvy;
    notifyListeners();
  }

  void loadSettingsValues(SettingsProvider prov) {
    setPoschodie(prov.getDefaultPodlazie);
    if (getZobrazNazvy != prov.getShowNazvy) toggleZobrazNazvy();
  }

  bool get getZobrazNazvy => _zobrazNazvy;

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
    //! ucebnu na destinacny a source waypoint
    setVyznacene([z, ciel]);
    List<dynamic> route = (Dijkstra.findPathFromGraph(
      edges,
      ucebnaToWaypoint[z] ?? z,
      ucebnaToWaypoint[ciel] ?? ciel,
    ));
    rozdelRouty(route);
    // nastavenie zobrazeneho podlazia na to kde sa zacina routa
    setPoschodie(
      suradniceWaypointov.keys.firstWhere(
        (e) {
          return suradniceWaypointov[e]!
              .containsKey(route.isNotEmpty ? route.first : _vyznacene.first);
        },
      ),
    );
    print(route);
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

  void resetMapDefaults() {
    _zobrazenePodlazie = 'HBP0';
    _odkial = 'D106';
    _odkialDefault = true;
    _kam = 'C109';
    _kamDefault = true;
    shouldDisplayButtons = [
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
    _zobrazNazvy = false;

    clearRoute();
  }

  void clearRoute() {
    for (var x in routy.keys) {
      routy[x] = [];
    }
    _vyznacene = [];
    notifyListeners();
  }

  Future<void> tvojeSur() async {
    if ((await Permission.location.isDenied) ||
        (await Permission.location.isRestricted) ||
        (await Permission.location.isPermanentlyDenied)) {
      await Permission.location.request();
    }
    if (!await Permission.location.isGranted) {
      return;
    }
    print(await Geolocator.getCurrentPosition());
  }

  void hore() {
    if (_zobrazenePodlazie == 'HBP0') {
      setPoschodie("HBP1");
    } else if (_zobrazenePodlazie == 'HBP1') {
      setPoschodie("HBP2");
    }
  }

  void dole() {
    if (_zobrazenePodlazie == 'HBP2') {
      setPoschodie("HBP1");
    } else if (_zobrazenePodlazie == 'HBP1') {
      setPoschodie("HBP0");
    }
  }
}
