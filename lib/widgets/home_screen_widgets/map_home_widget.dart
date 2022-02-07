import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:provider/provider.dart';

class MapHomeWidget extends StatelessWidget {
  const MapHomeWidget({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    final double widgetHeight = _size.height * (2 / 7);
    return Container(
        height: widgetHeight,
        decoration: BoxDecoration(
            color: Color(0xFFCECECE),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Container(
                height: widgetHeight * .2,
                child: Row(
                  children: [],
                )),
            Container(
                height: widgetHeight * .8,
                width: _size.width - 32,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset(
                      'assets/images/map_images/${Provider.of<SettingsProvider>(context, listen: false).getDefaultPodlazie}.svg'),
                ))
          ],
        ));
  }
}
