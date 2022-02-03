import 'package:flutter/material.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/jedalen_menu_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final jedalenProvider = Provider.of<JedalenProvider>(context);
    final _size = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey, size: _size),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...jedalenProvider.jedalenData.entries.map((e) {
              return JedalenMenuItem(
                size: _size,
                menuData: e,
              );
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: Navigator.of(context).pop,
                ),
                TextButton(
                  child: Text(
                    'Zobrazenie stránky jedálne',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onPressed: () => url.launch(jedalenProvider.jedalenURL),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
