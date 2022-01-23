import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/widgets/map_screen_widgets/mapCustomPaiter.dart';
import 'package:provider/provider.dart';

class FullscreenMapScreen extends StatelessWidget {
  const FullscreenMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: Navigator.of(context).pop),
      body: InteractiveViewer(
        child: SizedBox(
          width: 210,
          height: 297,
          child: Consumer<MapProvider>(
            builder: (ctx, prov, _) {
              return CustomPaint(
                foregroundPainter: MapCustomLinePainter(prov),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/map_images/${prov.getZobrazenePodlazie}.svg',
                      fit: BoxFit.fitWidth,
                      semanticsLabel: 'mapa skoly',
                    ),
                    if (prov.getZobrazNazvy)
                      SvgPicture.asset(
                        'assets/images/map_nazvy_overlays/${prov.getZobrazenePodlazie}_nazvy.svg',
                        fit: BoxFit.fitWidth,
                        semanticsLabel: 'mapa skoly',
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
