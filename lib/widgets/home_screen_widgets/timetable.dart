import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
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
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<EduPageProvider>(context, listen: false)
              .getDnesnyRozvrh
              .length,
          itemBuilder: (ctx, i) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Text(Provider.of<EduPageProvider>(context)
                  .getDnesnyRozvrh[i]
                  .subjectID),
            );
          },
        ),
      ),
    );
  }
}
