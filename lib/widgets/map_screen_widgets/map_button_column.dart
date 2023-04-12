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
          Tooltip(
            message: 'Zobraziť názvy učební',
            child: InkWell(
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
          ),
          Tooltip(
            message: 'Zobraziť mapu na celú obrazovku',
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              splashColor: Theme.of(context).primaryColor.withOpacity(.65),
              onTap: () => Navigator.of(context).pushNamed('/map/fullscreen'),
              child: Icon(
                Icons.fullscreen,
                size: 36,
                color: Colors.grey,
              ),
            ),
          ),
          Tooltip(
            message: 'Vyčistenie trasy',
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              splashColor: Theme.of(context).primaryColor.withOpacity(.65),
              onTap: () =>
                  Provider.of<MapProvider>(context, listen: false).clearRoute(),
              child: Icon(
                Icons.clear,
                size: 36,
                color: Colors.grey,
              ),
            ),
          ),
          Tooltip(
            message: 'Získanie polohy',
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              splashColor: Theme.of(context).primaryColor.withOpacity(.65),
              onTap: () =>
                  Provider.of<MapProvider>(context, listen: false).tvojeSur(),
              child: Icon(
                Icons.location_on_outlined,
                size: 36,
                color: Colors.grey,
              ),
            ),
          ),
          Tooltip(
            message: 'Vyššie poschodie',
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              splashColor: Theme.of(context).primaryColor.withOpacity(.65),
              onTap: () =>
                  Provider.of<MapProvider>(context, listen: false).hore(),
              child: Icon(
                Icons.arrow_upward,
                size: 36,
                color: Colors.grey,
              ),
            ),
          ),
          Tooltip(
            message: 'Nižšie poschodie',
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              splashColor: Theme.of(context).primaryColor.withOpacity(.65),
              onTap: () =>
                  Provider.of<MapProvider>(context, listen: false).dole(),
              child: Icon(
                Icons.arrow_downward,
                size: 36,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
