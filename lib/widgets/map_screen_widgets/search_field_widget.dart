import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/edu_get_utils.dart';
import 'package:kop_spse/widgets/map_screen_widgets/vyhladavanie_delegate.dart';
import 'package:provider/provider.dart';

class SearchFieldButton extends StatelessWidget {
  final typVyhladavania typ;
  final MapProvider provider;
  const SearchFieldButton({
    Key? key,
    required this.typ,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: Vyhladavanie(
            typ,
            getAllClassrooms(
                Provider.of<EduPageProvider>(context, listen: false)
                    .getEduData),
          ),
        );

        if (typ == typVyhladavania.odkial) provider.setOdkialDefault = false;
        if (typ == typVyhladavania.kam) provider.setKamDefault = false;
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
            typ == typVyhladavania.odkial
                ? 'Odkiaľ ' + provider.getOdkial
                : typ == typVyhladavania.kam
                    ? 'Cieľ ' + provider.getKam
                    : '',
            style: TextStyle(
                color: (typ == typVyhladavania.odkial
                        ? provider.getOdkialDefault
                        : typ == typVyhladavania.kam
                            ? provider.getKamDefault
                            : false)
                    ? Colors.grey
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
