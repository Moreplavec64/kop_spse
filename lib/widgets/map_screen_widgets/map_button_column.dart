import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:provider/provider.dart';

class MapIconButtonsColumn extends StatelessWidget {
  const MapIconButtonsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            splashColor: Provider.of<MapProvider>(context).getZobrazNazvy
                ? Theme.of(context).primaryColor.withOpacity(.65)
                : Colors.grey.withOpacity(.65),
            onTap: Provider.of<MapProvider>(context, listen: false)
                .toggleZobrazNazvy,
            child: Icon(
              Icons.title,
              size: 36,
              color: Provider.of<MapProvider>(context).getZobrazNazvy
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            splashColor: Theme.of(context).primaryColor.withOpacity(.65),
            onTap: () => Navigator.of(context).pushNamed('/map/fullscreen'),
            child: Icon(
              Icons.fullscreen,
              size: 36,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
