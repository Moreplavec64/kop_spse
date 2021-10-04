import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
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
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_size.height * .07);
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.infinite,
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            // ak sa uz animuje a pride k stlaceni, zisti ci kade sa ma vratit
            if (_animationController.isAnimating) {
              if (_animationController.value < 0.5)
                _animationController.reverse();
              else {
                _animationController.forward();
              }
            } else {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();
            }
            widget._scaffoldKey.currentState!.openDrawer();
          },
          icon: AnimatedIcon(
            progress: _animation,
            icon: AnimatedIcons.close_menu,
          ),
        ),
      ),
    );
  }
}
