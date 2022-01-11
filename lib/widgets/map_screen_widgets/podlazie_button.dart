import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:provider/provider.dart';

class MapPodlazieButton extends StatelessWidget {
  final String title;
  final String value;
  const MapPodlazieButton({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Provider.of<MapProvider>(context, listen: false).setPodlazie(value),
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Theme.of(context).primaryColor,
        ),
        width: 32,
        height: 24,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
