import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/widgets/home_screen_widgets/time_table_item.dart';

class HomeScreenTimeTable extends StatelessWidget {
  const HomeScreenTimeTable({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);
  final Size _size;

  @override
  Widget build(BuildContext context) {
    final EduPageProvider provider =
        Provider.of<EduPageProvider>(context, listen: false);
    final int subjNumber = provider.getDnesnyRozvrh.length;
    final double ttItemsize = (_size.width / subjNumber) - 10;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      // height: _size.height * (2 / 7),
      width: _size.width,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<EduPageProvider>(
                  builder: (_, v, __) => getZostavajuciCasWidget(v))),
          //* INDEX HODIN ROW
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 5),
            // width: _size.width,
            child: Row(
              children: provider.getDnesnyRozvrh
                  .map((e) => Container(
                      width: ttItemsize + 8,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        (e.period != -1) ? e.period.toString() + '.' : '',
                        textAlign: TextAlign.center,
                      )))
                  .toList(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.all(const Radius.circular(16)),
            ),
            width: _size.width - 10,
            height: _size.height / 7,
            child: ttItemsWidget(provider),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration? duration) {
    if (duration == null) return '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours == "00" ? '' : '$twoDigitHours:'}$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget getZostavajuciCasWidget(EduPageProvider v) {
    SizedBox nd = SizedBox.shrink();
    if (v.aktualnaHodina == null) return nd;
    if (v.zostavajuciCas == null) return nd;
    if (v.getDnesnyRozvrh.length == 1) {
      if (v.getDnesnyRozvrh.first.isEvent) return nd;
    }

    return Text(
      v.isPrestavka
          ? 'Aktuálne je prestávka, do ${v.aktualnaHodina!.period}. hodiny zostáva ${_printDuration(v.zostavajuciCas)}'
          : 'Prebieha ${v.aktualnaHodina!.period}. hodina, zostáva ' +
              _printDuration(v.zostavajuciCas),
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
    );
  }

  Widget ttItemsWidget(EduPageProvider v) {
    final int subjNumber = v.getDnesnyRozvrh.length;
    final double ttItemsize = (_size.width / subjNumber) - 10;
    if (subjNumber == 0)
      return Center(
          child: Text(
        'Na dnes sa nenašiel žiadny rozvrh',
        style: TextStyle(fontSize: 16),
      ));
    if (subjNumber == 1 && v.getDnesnyRozvrh.first.isEvent)
      return Center(
          child: Text(
        v.getDnesnyRozvrh.first.eventName ?? '',
        style: TextStyle(fontSize: 16),
      ));
    //Ak už nie je vyučovanie rozvrh sa už nebude ukazovať
    if (v.aktualnaHodina == null && v.isPrestavka == false)
      return Center(
          child: Text(
        'Škola už skončila/nezačala',
        style: TextStyle(fontSize: 16),
      ));

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: ((_size.height / 7 - ttItemsize - 10) / 2).abs(),
      ),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: v.getDnesnyRozvrh.length,
      itemBuilder: (ctx, i) {
        return TimeTableItem(
          index: i,
          size: ttItemsize,
        );
      },
    );
  }
}
