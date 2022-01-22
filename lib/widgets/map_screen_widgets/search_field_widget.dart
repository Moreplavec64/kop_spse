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
    bool isDefault = true;
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: Vyhladavanie(isOdkial),
        );
        isDefault = true;
      },
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * .4,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Text(
            isOdkial
                ? 'Odkial ' + provider.getOdkial
                : 'Ciel ' + provider.getKam,
            style: TextStyle(color: isDefault ? Colors.grey : Colors.black),
          ),
        ),
      ),
    );
  }
}
