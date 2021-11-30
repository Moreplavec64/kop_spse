import 'dart:math';
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
    final List<String>? dnesneMenu =
        jedalenProvider.jedalenData[DateTime(d.year, d.month, d.day)];
    // jedalenProvider.jedalenData[DateTime(2021, 11, 2)];
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(8),
      duration: const Duration(milliseconds: 200),
      height: (jedalenProvider.shouldBeExpanded && dnesneMenu!.length > 2
          ? _size.height * 1 / 7 + 12 * (jedalenProvider.jedalenData.length - 2)
          : _size.height * 1 / 7),
      width: _size.width - 10,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  const Icon(Icons.restaurant),
                  SizedBox(width: _size.width * .025),
                  Text(
                    'Obedové menu',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ]),
                //zobraz error ak je vikend, inak pre kazdy element v menu vytvori text widget,
                // ak je widget expandnuty zobrazi vsetky, inak prve dve
                ...dnesneMenu != null && dnesneMenu.length != 0
                    ? dnesneMenu.map((e) => Text(e)).toList().sublist(
                          0,
                          jedalenProvider.shouldBeExpanded
                              ? dnesneMenu.length - 1
                              : min(2, dnesneMenu.length),
                        )
                    : [
                        Text(
                          'Na dnes nieje vypísané žiadne menu',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed('/menu'),
                          onLongPress: () async =>
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
