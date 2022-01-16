import 'package:flutter/material.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/map_constants.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class MapCustomLinePainter extends CustomPainter {
  final MapProvider provider;
  MapCustomLinePainter(this.provider);

  @override
  void paint(Canvas canvas, Size size) {
    //*Kreslenie trasy
    final List<String> toDrawPath =
        provider.routy[provider.getZobrazenePodlazie] ?? [];
    final suradnicePrePodlazie =
        suradniceWaypointov[provider.getZobrazenePodlazie];
    final Color primaryColor = Color.fromRGBO(3, 192, 60, 1);
    final Paint paint = Paint()
      ..strokeWidth = 1
      ..color = primaryColor;
    for (int i = 0; i < toDrawPath.length - 1; i++) {
      canvas.drawLine(suradnicePrePodlazie![toDrawPath[i]] ?? Offset(0, 0),
          suradnicePrePodlazie[toDrawPath[i + 1]] ?? Offset(0, 0), paint);
    }
    //*Vyznacenie miestnosti
    List<String> vyznac = provider.getVyznacene
        .where(
          (e) => suradniceUcebni[provider.getZobrazenePodlazie]!.containsKey(e),
        )
        .toList();
    final Pattern pattern = DiagonalStripesLight(
        bgColor: Colors.transparent, fgColor: primaryColor);
    for (String ucebna in vyznac) {
      Path p = Path();
      Rect r = suradniceUcebni[provider.getZobrazenePodlazie]![ucebna] ??
          Rect.fromLTRB(0, 0, 0, 0);
      p.addRect(r);

      // Paint the pattern on the rectangle.
      pattern.paintOnRect(canvas, size, r);

      canvas.drawPath(
          p,
          paint
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
