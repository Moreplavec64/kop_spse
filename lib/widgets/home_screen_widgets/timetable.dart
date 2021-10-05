import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/widgets/home_screen_widgets/time_table_idem.dart';

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
      child: Stack(
        children: [
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
                    padding:
                        EdgeInsets.symmetric(vertical: _size.height / 7 / 4),
                    child: TimeTableItem(
                      index: i,
                      size: _size,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
