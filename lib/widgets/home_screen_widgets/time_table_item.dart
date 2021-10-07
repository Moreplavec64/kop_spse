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
  final Size size;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EduPageProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        _showMyDialog(
          context: context,
          lessonData: provider.getDnesnyRozvrh[index],
        );
      },
      child: Container(
        color: Colors.red,
        margin: const EdgeInsets.all(5),
        height: size.height / 7,
        width: (size.width / provider.getDnesnyRozvrh.length) - 10,
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Text(
            EduIdUtil.idToSubject(provider.getEduData,
                    provider.getDnesnyRozvrh[index].subjectID)
                .substring(0, 3)
                .toUpperCase(),
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
                '${lessonData.period}. hodina  ${lessonData.startTime} - ${lessonData.endTime}',
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
