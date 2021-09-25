import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
