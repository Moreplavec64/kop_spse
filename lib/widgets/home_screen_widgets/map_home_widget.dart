import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/utils/edu_id_util.dart';

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
        decoration: const BoxDecoration(
            color: const Color(0xFFCECECE),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Container(
                height: widgetHeight * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MapHomeButton(
                      title: 'Rýchla Nav',
                      icon: CupertinoIcons.globe,
                      bgColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onTap: () {
                        //TODO fix ked uz niesu nasledujuce hodiny
                        final mapProv =
                            Provider.of<MapProvider>(context, listen: false);
                        final eduProv = Provider.of<EduPageProvider>(context,
                            listen: false);

                        final String aktUcebna =
                            eduProv.aktualnaHodina!.classroomID;

                        final String naslUcebna = eduProv
                            .getDnesnyRozvrh[eduProv.getDnesnyRozvrh
                                    .indexOf(eduProv.aktualnaHodina!) +
                                1]
                            .classroomID;

                        mapProv.setodkial(EduIdUtil.idToNavClassroom(
                            eduProv.getEduData, aktUcebna));
                        mapProv.setKam(EduIdUtil.idToNavClassroom(
                            eduProv.getEduData, naslUcebna));

                        Navigator.of(context).pushNamed('/map');
                      },
                    ),
                    const SizedBox(width: 16),
                    MapHomeButton(
                      title: 'Navigácia',
                      icon: Icons.directions_outlined,
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.of(context).pushNamed('/map');
                      },
                    ),
                  ],
                )),
            Container(
              height: widgetHeight * .7,
              width: _size.width - 32,
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.antiAlias,
                  child: GestureDetector(
                    //TODO nastavenie podlazia
                    onTap: () =>
                        Navigator.of(context).pushNamed('/map/fullscreen'),
                    child: Consumer<MapProvider>(
                      builder: ((context, value, child) => Stack(
                            children: [
                              Hero(
                                tag: 'mapa',
                                child: SvgPicture.asset(
                                  'assets/images/map_images/${value.getZobrazenePodlazie}.svg',
                                  fit: BoxFit.fitHeight,
                                  semanticsLabel: 'mapa skoly',
                                ),
                              ),
                              if (value.getZobrazNazvy)
                                SvgPicture.asset(
                                  'assets/images/map_nazvy_overlays/${value.getZobrazenePodlazie}_nazvy.svg',
                                  fit: BoxFit.fitWidth,
                                  semanticsLabel: 'mapa skoly',
                                ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class MapHomeButton extends StatelessWidget {
  const MapHomeButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.textColor,
    required this.bgColor,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final IconData icon;
  final Color textColor;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(16)))),
        ),
        onPressed: () => onTap(),
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(icon, color: textColor)),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor,
            ),
          )
        ]));
  }
}
