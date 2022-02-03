import 'package:kop_spse/utils/edu_get_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/utils/edu_id_util.dart';
import 'package:kop_spse/widgets/home_screen_widgets/tt_alert_dialog.dart';

class TimeTableItem extends StatelessWidget {
  const TimeTableItem({
    Key? key,
    required this.index,
    required this.size,
  }) : super(key: key);

  final int index;
  final double size;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EduPageProvider>(context, listen: false);
    final String shortTitleHodiny = EduIdUtil.idToShortSubject(
            provider.getEduData, provider.getDnesnyRozvrh[index].subjectID) ??
        'Sviatok';
    final Color farba = getColor(shortTitleHodiny, provider);

    return GestureDetector(
      onTap: () {
        showMyDialog(
          context: context,
          lessonData: provider.getDnesnyRozvrh[index],
          farba: farba,
        );
      },
      child: Consumer<EduPageProvider>(
        builder: (__, v, _) => Container(
          decoration: BoxDecoration(
            color: farba,
            border: v.isPrestavka || v.aktualnaHodina == null
                ? Border.all(color: Colors.transparent, width: 0)
                //TODO overit ci spravne vyznacuje
                : v.aktualnaHodina!.period - 1 == index
                    ? Border.all(
                        color: Theme.of(context).primaryColor, width: 2)
                    : Border.all(color: Colors.transparent, width: 0),
          ),
          height: size,
          width: size,
          margin: const EdgeInsets.all(4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Stack(
              children: [
                Text(
                  shortTitleHodiny,
                  style: TextStyle(
                    foreground: Paint()
                      ..strokeWidth = 1
                      ..color = Colors.black
                      ..style = PaintingStyle.stroke,
                    // color: Colors.white,

                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  shortTitleHodiny,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
