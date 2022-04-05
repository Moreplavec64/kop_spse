import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:provider/provider.dart';

enum typVyhladavania { odkial, kam, zobrazenie }

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
  final typVyhladavania typ;
  List<String> vsetkyUcebne;

  Vyhladavanie(
    this.typ,
    this.vsetkyUcebne,
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: Navigator.of(context).pop,
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
    final SettingsProvider sp = Provider.of<SettingsProvider>(context);
    final String tmpQuery = query.toUpperCase();
    final Iterable<String> tmpDlheNazvy =
        ucebne.map((e) => vsetkyUcebne.firstWhere(
              (element) => element.contains(e),
              orElse: () => e,
            ));
    //vsetky waypointy, prelozi tie co sa da na dlhe nazvy ucebni
    //a tie co nemaju dlhy nazov z edu tak sa vypisu ako nazov waypointu
    List<String> suggestions = query.isEmpty
        ? tmpDlheNazvy.toList()
        : tmpDlheNazvy
            .where((element) => element.toUpperCase().contains(tmpQuery))
            .toList();

    print(sp.recentSearch);

    final List<String> recent = [
      ...sp.recentSearch.where((e) => suggestions.contains(e))
    ];
    suggestions =
        recent + suggestions.where((e) => !recent.contains(e)).toList();
    // print(suggestions);
    //*Vypisanie ucebni pre ktore sa nenasiel korespondujuci waypoint
    // for (String ucebna in vsetkyUcebne) {
    //   var x = ucebne.firstWhere((element) => ucebna.contains(element),
    //       orElse: () => '');
    //   if (x == '') print(ucebna + " : " + (x.isNotEmpty ? x : ''));
    // }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: suggestions.length + (recent.length > 0 ? 1 : 0),
      itemBuilder: (ctx, index) {
        final String ucebna = suggestions[
            index - (index >= recent.length && recent.length > 0 ? 1 : 0)];
        //.where.reduce namiesto firstwhere
        //zaruci najdlhsi match string z vsetkych ucebni
        final String value = ucebne
            .where((e) => ucebna.contains(e))
            .reduce((r, e) => r.length < e.length ? e : r);

        // print({ucebna, value});
        if (recent.isNotEmpty &&
            recent.length == index &&
            recent.length != suggestions.length) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Divider(
                thickness: .9,
                color: Color.fromARGB(150, 0, 0, 0),
              ));
        }
        //TODO fix dvakrat zobrazovanie ak uz navstivene
        return ListTile(
          leading: Icon(Icons.class_),
          onTap: () {
            final provider = Provider.of<MapProvider>(context, listen: false);
            if (typ == typVyhladavania.odkial)
              provider.setodkial(value);
            else if (typ == typVyhladavania.kam)
              provider.setKam(value);
            else if (typ == typVyhladavania.zobrazenie)
              provider.setVyznacene([value]);
            Navigator.of(context).pop();
            showResults(context);
            print(value);
            sp.addRecentSearch(ucebna);
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: ucebna.substring(
                      0, ucebna.toUpperCase().indexOf(tmpQuery)),
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: ucebna.substring(
                          ucebna.toUpperCase().indexOf(tmpQuery),
                          ucebna.toUpperCase().indexOf(tmpQuery) +
                              tmpQuery.length),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ucebna.substring(
                          ucebna.toUpperCase().indexOf(tmpQuery) +
                              tmpQuery.length),
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              //ak v ucebniach neexistuje nazov ucebne, tzn nieje v datach aplikacie ale existuje v edupagi
              if (!ucebne.contains(ucebna))
                Text(
                  ucebne.firstWhere(
                    (element) => ucebna.contains(element),
                    orElse: () => 'Neexistuje na mape',
                  ),
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        );
      },
    );
  }
}
