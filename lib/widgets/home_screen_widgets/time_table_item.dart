import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kop_spse/models/plan.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/utils/edu_id_util.dart';
import 'package:provider/provider.dart';

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

    return GestureDetector(
      onTap: () {
        _showMyDialog(
          context: context,
          lessonData: provider.getDnesnyRozvrh[index],
        );
      },
      child: Container(
        height: size,
        width: size,
        color: _getColor(shortTitleHodiny, provider),
        margin: const EdgeInsets.all(4),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            shortTitleHodiny,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showMyDialog({
  required BuildContext context,
  required LessonPlan lessonData,
}) async {
  final provider = Provider.of<EduPageProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final longNazov = EduIdUtil.idToLongSubject(
        provider.getEduData,
        lessonData.subjectID,
      );
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Text(
                longNazov.replaceRange(0, 1, longNazov[0].toUpperCase()),
                textAlign: TextAlign.center,
              ),
              Text(
                '${lessonData.period}. hodina  ${lessonData.startTime.hour}:${lessonData.startTime.minute} - ${lessonData.endTime.hour}:${lessonData.endTime.minute}',
                textAlign: TextAlign.center,
              ),
              if (lessonData.skupina.isNotEmpty)
                Text(
                  'Skupina ' + lessonData.skupina,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Color _getColor(String nazovHodiny, EduPageProvider provider) {
  if (provider.colorMap.keys.contains(nazovHodiny)) {
    return provider.colorMap[nazovHodiny]!;
  } else {
    // ak sa nenachadza v liste farieb, vyberie sa random farba a priradi sa do listu
    // aby dalsie rovnake hodiny boli vyfarbene rovnakou farbou
    final randColor = provider.colorMap.values.elementAt(
      Random().nextInt(provider.colorMap.values.length),
    );
    provider.colorMap.addAll({nazovHodiny: randColor});
    return randColor;
  }
}
