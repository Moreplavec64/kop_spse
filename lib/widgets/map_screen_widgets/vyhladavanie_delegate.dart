import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:provider/provider.dart';

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
  List<String> vsetkyUcebne;

  Vyhladavanie(
    this.isOdkial,
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
    final String tmpQuery = query.toUpperCase();
    //vsetky waypointy, prelozi tie co sa da na dlhe nazvy ucebni
    //a tie co nemaju dlhy nazov z edu tak sa vypisu ako nazov waypointu
    final suggestions = query.isEmpty
        ? ucebne
            .map((e) => vsetkyUcebne.firstWhere(
                  (element) => element.contains(e),
                  orElse: () => e,
                ))
            .toList()
        : ucebne
            .map((e) => vsetkyUcebne.firstWhere(
                  (element) => element.contains(e),
                  orElse: () => e,
                ))
            .where((element) => element.toUpperCase().contains(tmpQuery))
            .toList();

    print(suggestions);

    print(suggestions);
    for (String ucebna in vsetkyUcebne) {
      var x = ucebne.firstWhere((element) => ucebna.contains(element),
          orElse: () => '');
      if (x == '') print(ucebna + " : " + (x.isNotEmpty ? x : ''));
    }
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (ctx, index) {
        final String ucebna = suggestions[index];
        final String value = ucebne.firstWhere((e) => ucebna.contains(e));

        return ListTile(
          leading: Icon(Icons.class_),
          onTap: () {
            final provider = Provider.of<MapProvider>(context, listen: false);
            Navigator.of(context).pop();
            showResults(context);
            isOdkial ? provider.setodkial(value) : provider.setKam(value);
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
              if (!ucebne.contains(ucebna))
                Text(
                  ucebne.firstWhere(
                    (element) => ucebna.contains(element),
                    orElse: () => 'Neexistuje na mape',
                  ),
                  style: TextStyle(color: Colors.grey),
                )
            ],
          ),
        );
      },
    );
  }
}
