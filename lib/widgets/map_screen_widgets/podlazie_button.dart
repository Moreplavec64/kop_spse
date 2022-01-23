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
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(34)),
      splashColor: Theme.of(context).primaryColor.withOpacity(.6),
      onTap: () =>
          Provider.of<MapProvider>(context, listen: false).setPoschodie(value),
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Provider.of<MapProvider>(context).getZobrazenePodlazie == value
              ? Colors.yellowAccent[700]
              : Theme.of(context).primaryColor,
        ),
        width: 34,
        height: 34,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
