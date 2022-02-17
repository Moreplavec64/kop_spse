import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/models/plan.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/map.dart';
import 'package:kop_spse/utils/edu_get_utils.dart';
import 'package:kop_spse/utils/edu_id_util.dart';
import 'package:kop_spse/utils/map_constants.dart';

Future<void> showMyDialog({
  required BuildContext context,
  required LessonPlan lessonData,
  required final Color farba,
}) async {
  final provider = Provider.of<EduPageProvider>(context, listen: false);
  String ucebna = EduIdUtil.idToNavClassroom(
    provider.getEduData,
    lessonData.classroomID,
  );
  final MapProvider mapprov = Provider.of(context, listen: false);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final longNazov = EduIdUtil.idToLongSubject(
        provider.getEduData,
        lessonData.subjectID,
      );
      print(getAllClassrooms(provider.getEduData));
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(64)),
                    onTap: Navigator.of(context).pop,
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Text(
                longNazov.replaceRange(0, 1, longNazov[0].toUpperCase()),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              if (lessonData.skupina.isNotEmpty)
                Text(
                  'Skupina ' + lessonData.skupina,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              Text(
                '${lessonData.period}. hodina  ${lessonData.startTime.hour}:${lessonData.startTime.minute} - ${lessonData.endTime.hour}:${lessonData.endTime.minute}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Ucebna : ' +
                    EduIdUtil.idToLongClassroom(
                      provider.getEduData,
                      lessonData.classroomID,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Vyučujúci : ' +
                    EduIdUtil.idToTeacher(
                      provider.getEduData,
                      lessonData.ucitelID,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.directions,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      mapprov.setodkial(ucebna);
                      Navigator.of(context).pushNamed('/map');
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.map_outlined,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      mapprov.setVyznacene([ucebna]);
                      Navigator.of(context).pushNamed('/map');
                      mapprov.setPoschodie(
                        suradniceWaypointov.keys.firstWhere(
                          (e) => suradniceWaypointov[e]!
                              .containsKey(ucebnaToWaypoint[ucebna] ?? ucebna),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
