import 'package:flutter/material.dart';
import 'package:kop_spse/widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        size: MediaQuery.of(context).size,
      ),
      drawer: const Drawer(),
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
}
