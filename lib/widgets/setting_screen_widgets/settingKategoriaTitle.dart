import 'package:flutter/material.dart';

class SettingKategoriaTitle extends StatelessWidget {
  const SettingKategoriaTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
