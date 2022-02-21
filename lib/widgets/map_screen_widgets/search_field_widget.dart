import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/edu_get_utils.dart';
import 'package:kop_spse/widgets/map_screen_widgets/vyhladavanie_delegate.dart';
import 'package:provider/provider.dart';

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
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: Vyhladavanie(
            isOdkial,
            getAllClassrooms(
                Provider.of<EduPageProvider>(context, listen: false)
                    .getEduData),
          ),
        );
        isOdkial
            ? provider.setOdkialDefault = false
            : provider.setKamDefault = false;
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
                ? 'Odkiaľ ' + provider.getOdkial
                : 'Cieľ ' + provider.getKam,
            style: TextStyle(
                color: (isOdkial
                        ? provider.getOdkialDefault
                        : provider.getKamDefault)
                    ? Colors.grey
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
