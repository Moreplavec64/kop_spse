import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/widgets/map_screen_widgets/search_field_widget.dart';
import 'package:kop_spse/widgets/map_screen_widgets/vyhladavanie_delegate.dart';
import 'package:provider/provider.dart';

class NavigationSearchWidget extends StatelessWidget {
  const NavigationSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                const CircleAvatar(
                  radius: 2.5,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Consumer<MapProvider>(
              builder: (_, value, __) {
                return SearchFieldButton(
                  typ: typVyhladavania.odkial,
                  provider: value,
                );
              },
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            final prov = Provider.of<MapProvider>(context, listen: false);
            var odkial = prov.getOdkial;
            prov.setodkial(prov.getKam);
            prov.setKam(odkial);
          },
          child: Icon(
            Icons.swap_vert_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 4,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Consumer<MapProvider>(
              builder: (_, value, __) {
                return SearchFieldButton(
                  typ: typVyhladavania.kam,
                  provider: value,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
