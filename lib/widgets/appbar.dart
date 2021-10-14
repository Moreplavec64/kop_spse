import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required Size size,
  })  : _scaffoldKey = scaffoldKey,
        _size = size,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final Size _size;

  @override
  Size get preferredSize => Size.fromHeight(
      (_size.height - kToolbarHeight - kBottomNavigationBarHeight) * .07);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
    );
  }
}
