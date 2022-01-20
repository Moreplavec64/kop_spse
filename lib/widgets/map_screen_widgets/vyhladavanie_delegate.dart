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
            Navigator.of(context).pop();
            showResults(context);
            isOdkial ? provider.setodkial(ucebna) : provider.setKam(ucebna);
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
