import 'package:flutter/material.dart';
import 'package:kop_spse/models/plan.dart';
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

    final _date = DateTime.now().subtract(Duration(hours: 5));
    final LessonPlan aktualnaHodina = provider.getDnesnyRozvrh.firstWhere(
        (e) => _date.isAfter(e.startTime) && _date.isBefore(e.endTime));

    final Duration zostavajuciCas = aktualnaHodina.endTime.difference(_date);
    return Container(
      height: _size.height * (1.5 / 7),
      width: _size.width,
      child: Column(
        children: [
          //TODO prestavka
          Text(_printDuration(zostavajuciCas)),
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
                      print('AAAAAAAAAAA' + subjNumber.toString());
                      print(provider.getDnesnyRozvrh[subjNumber - 1].isEvent);
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

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
