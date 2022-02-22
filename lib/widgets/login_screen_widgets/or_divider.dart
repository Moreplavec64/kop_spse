import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String label;
  final double height;

  const OrDivider({
    required this.label,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              thickness: .6,
              color: Colors.grey,
              height: height,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              thickness: .6,
              color: Colors.grey,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
