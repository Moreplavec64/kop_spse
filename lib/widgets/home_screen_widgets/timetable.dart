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
      height: _size.height * (2 / 7),
      width: _size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<EduPageProvider>(
                builder: (_, v, __) =>
                    v.aktualnaHodina != null && v.zostavajuciCas != null
                        ? Text(
                            v.isPrestavka
                                ? 'Aktualne je prestavka, do ${v.aktualnaHodina!.period}. hodiny zostáva ${_printDuration(v.zostavajuciCas)}'
                                : 'Prebieha ${v.aktualnaHodina!.period}. hodina, do prestávky zostáva ' +
                                    _printDuration(v.zostavajuciCas),
                            style: TextStyle(fontSize: 18),
                          )
                        : SizedBox.shrink()),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: _size.width,
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
            child: subjNumber == 0
                ? Center(
                    child: Text(
                    'Na dnes sa nenašiel žiadny rozvrh',
                    style: TextStyle(fontSize: 16),
                  ))
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          ((_size.height / 7 - ttItemsize - 10) / 2).abs(),
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.getDnesnyRozvrh.length,
                    itemBuilder: (ctx, i) {
                      return TimeTableItem(
                        index: i,
                        size: ttItemsize,
                      );
                    },
                  ),
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
    return "$twoDigitHours${twoDigitHours.length == 0 ? '' : ':'}$twoDigitMinutes:$twoDigitSeconds";
  }
}
