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
    final suggestions = query.isEmpty
        ? ucebne
        : ucebne.where((element) => element.contains(tmpQuery)).toList();
    for (String ucebna in vsetkyUcebne) {
      var x = ucebne.firstWhere((element) => ucebna.contains(element),
          orElse: () => '');
      if (x == '') print(ucebna + " : " + (x.isNotEmpty ? x : ''));
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final String ucebna = suggestions[index];
        final String celyNazov = vsetkyUcebne.firstWhere(
          (element) => element.contains(ucebna),
          orElse: () => ucebna,
        );
        return ListTile(
          leading: Icon(Icons.class_),
          onTap: () {
            final provider = Provider.of<MapProvider>(context, listen: false);
            Navigator.of(context).pop();
            showResults(context);
            isOdkial ? provider.setodkial(ucebna) : provider.setKam(ucebna);
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: celyNazov.substring(0, celyNazov.indexOf(tmpQuery)),
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: tmpQuery,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: celyNazov.substring(
                          celyNazov.indexOf(tmpQuery) + tmpQuery.length),
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (celyNazov != ucebna)
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
      itemCount: suggestions.length,
    );
  }
}
