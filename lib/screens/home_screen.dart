import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

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
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: AnimatedIcon(
            progress: _animation,
            icon: AnimatedIcons.close_menu,
          ),
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Center(
            child: Text('Home Screen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Text('Druha page'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
