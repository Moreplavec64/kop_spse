import 'package:flutter/material.dart';
import 'package:kop_spse/models/plan.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/utils/edu_id_util.dart';
import 'package:provider/provider.dart';

class HomeScreenTimeTable extends StatelessWidget {
  const HomeScreenTimeTable({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.height * (2 / 7),
      width: _size.width,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(16))),
            width: _size.width,
            height: _size.height / 7,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<EduPageProvider>(context, listen: false)
                  .getDnesnyRozvrh
                  .length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: _size.height / 7 / 4),
                  child: TimeTableItem(
                    index: i,
                    size: _size,
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

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
      return AlertDialog(
        title: Text(
          EduIdUtil.idToSubject(
            provider.getEduData,
            lessonData.subjectID,
          ),
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
