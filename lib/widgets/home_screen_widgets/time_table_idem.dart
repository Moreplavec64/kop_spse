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
            EduIdUtil.idToSubject(
                provider.getEduData, provider.getDnesnyRozvrh[index].subjectID),
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
        title: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Text(
              longNazov.replaceRange(0, 1, longNazov[0].toUpperCase()),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
