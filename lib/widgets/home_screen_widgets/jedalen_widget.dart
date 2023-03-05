import 'dart:math';
import 'dart:ui';
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
      height: getWidgetHeight(jedalenProvider, dnesneMenu),
      width: _size.width - 10,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ]),
                //zobraz error ak je vikend, inak pre kazdy element v menu vytvori text widget,
                // ak je widget expandnuty zobrazi vsetky, inak prve dve'
                ...createJedalenListContents(
                    dnesneMenu, jedalenProvider.shouldBeExpanded),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.4)),
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor)),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/menu'),
                          onLongPress: () {
                            // await Provider.of<JedalenProvider>(context,
                            //           listen: false)
                            //       .fetchJedalenData();

                            dnesneMenu!.forEach((e) {
                              print(e);
                              TextSpan t = TextSpan(text: e);
                              List<LineMetrics> lines =
                                  TextPainter(text: t).computeLineMetrics();
                              print(lines.length);
                            });
                          },
                          child: Text('Týždenné menu')),
                    ),
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.4)),
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor)),
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

  double getWidgetHeight(
    JedalenProvider jedalenProvider,
    List<String>? dnesneMenu,
  ) {
    final double notExpanded = _size.height * 1 / 7;
    final double expanded =
        notExpanded + 16 * jedalenProvider.jedalenData.length;
    if (dnesneMenu == null) return notExpanded;
    if (!jedalenProvider.shouldBeExpanded || dnesneMenu.length < 2)
      return notExpanded;

    return expanded;
  }

  List<Widget> createJedalenListContents(
      List<String>? dnesneMenu, bool shouldBeExpanded) {
    List<Widget> noData = [
      Text(
        'Na dnes nieje vypísané žiadne menu',
        style: TextStyle(fontSize: 17),
        textAlign: TextAlign.center,
      )
    ];
    if (dnesneMenu == null) return noData;
    if (dnesneMenu.isEmpty) return noData;
    if (dnesneMenu.length == 1) {
      if (dnesneMenu.first.trim().length == 0) return noData;
    }

    return dnesneMenu
        .map((e) {
          return Text(
            e,
            textAlign: TextAlign.center,
          );
        })
        .toList()
        .sublist(0,
            shouldBeExpanded ? dnesneMenu.length : min(2, dnesneMenu.length));
  }
}
