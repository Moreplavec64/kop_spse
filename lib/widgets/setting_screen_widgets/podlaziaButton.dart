import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:provider/provider.dart';

class PodlazieDropDownSettingButton extends StatefulWidget {
  const PodlazieDropDownSettingButton({
    Key? key,
  }) : super(key: key);

  @override
  State<PodlazieDropDownSettingButton> createState() =>
      _PodlazieDropDownSettingButtonState();
}

class _PodlazieDropDownSettingButtonState
    extends State<PodlazieDropDownSettingButton> {
  @override
  Widget build(BuildContext context) {
    final SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return DropdownButton(
        onTap: () => setState(() {}),
        selectedItemBuilder: (ctx) =>
            List.generate(suradniceUcebni.keys.length, (index) {
              String nazov = suradniceUcebni.keys.elementAt(index);
              return DropdownMenuItem<String>(
                  onTap: () => provider.setDefaultPodlazie = nazov,
                  value: nazov,
                  child: Text(
                    nazov,
                  ));
            }),
        value: provider.getDefaultPodlazie,
        items: List.generate(suradniceUcebni.keys.length, (index) {
          String nazov = suradniceUcebni.keys.elementAt(index);
          return DropdownMenuItem<String>(
              onTap: () {
                provider.setDefaultPodlazie = nazov;
                Provider.of<MapProvider>(context, listen: false)
                    .loadSettingsValues(
                        Provider.of<SettingsProvider>(context, listen: false));
              },
              value: nazov,
              child: Text(
                nazov,
                style: TextStyle(
                    color: nazov == provider.getDefaultPodlazie
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ));
        }),
        onChanged: (x) {});
  }
}
