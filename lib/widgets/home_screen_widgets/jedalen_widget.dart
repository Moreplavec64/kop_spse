import 'package:flutter/material.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:provider/provider.dart';

class JedalenHomeScreenWidget extends StatelessWidget {
  const JedalenHomeScreenWidget({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    final jedalenProvider = Provider.of<JedalenProvider>(context);
    final DateTime d = DateTime.now();
    final dnesneMenu =
        // jedalenProvider.jedalenData[DateTime(d.year, d.month, d.day)];
        jedalenProvider.jedalenData[DateTime(2021, 11, 2)];
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height:
          _size.height * (jedalenProvider.shouldBeExpanded ? (4 / 7) : (1 / 7)),
      width: _size.width * .8,
      color: Colors.grey[200],
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //zobraz error ak je vikend, inak pre kazdy element v menu vytvori text widget,
                // ak je widget expandnuty zobrazi vsetky, inak prve dve
                ...dnesneMenu != null
                    ? dnesneMenu.map((e) => Text(e)).toList().sublist(
                          0,
                          jedalenProvider.shouldBeExpanded
                              ? dnesneMenu.length - 1
                              : 2,
                        )
                    : [Text('Na dnes nieje vypisany rozvrh')],
                // SizedBox.expand(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () async =>
                              await Provider.of<JedalenProvider>(context,
                                      listen: false)
                                  .fetchJedalenData(),
                          child: Text('refetch data')),
                    ),
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () =>
                              jedalenProvider.toggleShouldBeExpanded(),
                          child: Text(
                              'Zobraziť ${jedalenProvider.shouldBeExpanded ? 'menej' : 'viac'}')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
