import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kop_spse/main.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/utils/formatters.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required Size size,
  })  : _scaffoldKey = scaffoldKey,
        _size = size,
        super(key: key);

  Size get preferredSize => Size.fromHeight(
      (_size.height - kToolbarHeight - kBottomNavigationBarHeight) * .07);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final Size _size;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  DateTime dtNow = DateTime.now();
  late final Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      Provider.of<EduPageProvider>(context, listen: false).updateAktualne();
      if (dtNow.minute != DateTime.now().minute && mounted)
        setState(() {
          dtNow = DateTime.now();
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD');
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        onPressed: () {
          ModalRoute.of(context)!.canPop
              ? Navigator.of(context).pop()
              : widget._scaffoldKey.currentState!.openDrawer();
        },
        icon: ModalRoute.of(context)!.canPop
            ? Icon(Icons.arrow_back)
            : Icon(Icons.menu),
      ),
      title: Text(Formatters.ddMMMMyy(dtNow) +
          '  ${DateFormat('HH:mm').format(dtNow)}'),
    );
  }
}
