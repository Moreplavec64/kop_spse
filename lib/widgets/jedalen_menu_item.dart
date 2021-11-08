import 'package:flutter/material.dart';
import 'package:kop_spse/utils/formatters.dart';

class JedalenMenuItem extends StatelessWidget {
  const JedalenMenuItem({
    Key? key,
    required Size size,
    required this.menuData,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final MapEntry<DateTime, List<String>> menuData;

  @override
  Widget build(BuildContext context) {
    final mesiac =
        Formatters.svkMesiacDoCislo.keys.toList()[menuData.key.month - 1];
    //TODO outline na dnesny item
    return Container(
      height: _size.height * .15,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Formatters.getDenFromWeekday(menuData.key.weekday),
              ),
              Text(
                menuData.key.day.toString(),
                style: TextStyle(fontSize: 24),
              ),
              Text("${mesiac[0].toUpperCase()}${mesiac.substring(1)}"),
              Text(menuData.key.year.toString()),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: menuData.value.isNotEmpty
                ? menuData.value.map((e) => Text(e)).toList()
                : [
                    Container(
                      width: _size.width * .7,
                      child: Text(
                        'Na tento deň neboli vypísané žiadne jedlá',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 7,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
          ),
        ],
      ),
    );
  }
}
