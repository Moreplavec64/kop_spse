import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/widgets/map_screen_widgets/vyhladavanie_delegate.dart';

class SearchFieldButton extends StatelessWidget {
  final bool isOdkial;
  final MapProvider provider;
  const SearchFieldButton({
    Key? key,
    required this.isOdkial,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showSearch(
        context: context,
        delegate: Vyhladavanie(isOdkial),
      ).then((value) {
        print('Odkial ' + provider.getOdkial);
        print('Ciel ' + provider.getKam);
      }),
      child: Text(isOdkial
          ? 'Odkial ' + provider.getOdkial
          : 'Ciel ' + provider.getKam),
    );
  }
}
