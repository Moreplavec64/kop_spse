import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as h;

import 'package:intl/intl.dart';
import 'package:kop_spse/utils/formatters.dart';

class JedalenProvider with ChangeNotifier {
  bool _expandedHomeScreenWidget = false;
  bool get shouldBeExpanded => _expandedHomeScreenWidget;
  void toggleShouldBeExpanded() {
    _expandedHomeScreenWidget = !_expandedHomeScreenWidget;
    notifyListeners();
  }

  final String _jedalenURL =
      'https://www.jedalen.sk/Pages/EatMenu?Ident=rNT9rWnuqD';
  final Map<DateTime, List<String>> jedalenData = {};

  Future<void> fetchJedalenData() async {
    final response = await http.get(Uri.parse(_jedalenURL));
    print(response.statusCode);
    final document = html.parse(response.body);
    List<h.Element> menu =
        document.getElementsByClassName('menu-day-innertable');
    menu = menu.map((e) => e.children.first.children.first).toList();
    menu = menu.sublist(0, 5);
    //pre kazdy obed tyzdna pondelok az piatok
    for (var x in menu) {
      List<h.Element> tdList = x.children;
      //datum
      //[den, mesiac slovom, rok]
      List<String> date = tdList.first.text
          .replaceAll(RegExp('\\s+'), ' ')
          .trim()
          .split(' ')
        ..removeAt(0);
      DateTime dateTime = DateFormat('dd MM yyyy').parse(
          '${date[0]} ${Formatters.svkMesiacDoCislo[date[1]].toString()} ${date[2]}');
      print(dateTime);
      // print(tdList[1].children.first.children.first.children);
      String menu = tdList[1].getElementsByClassName('menu-tdmenu').first.text;
      jedalenData[dateTime] = menu.split('\n');
    }
    // print(jedalenData);
  }
}
