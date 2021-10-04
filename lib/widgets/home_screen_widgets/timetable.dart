import 'package:flutter/material.dart';
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
      child: Center(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: _size.height * (0.75 / 7)),
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<EduPageProvider>(context, listen: false)
              .getDnesnyRozvrh
              .length,
          itemBuilder: (ctx, i) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                EduIdUtil.idToSubject(
                    Provider.of<EduPageProvider>(
                      context,
                      listen: false,
                    ).getEduData,
                    Provider.of<EduPageProvider>(context)
                        .getDnesnyRozvrh[i]
                        .subjectID),
              ),
            );
          },
        ),
      ),
    );
  }
}
