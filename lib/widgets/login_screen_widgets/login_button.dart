import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton(this.onPressedFunction, this.labelText);

  final Future<void> Function() onPressedFunction;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      //zaoblenie aj containeru aj flatButtonu
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: _size.height * .08 < 40 ? _size.height * .08 : 40,
          width: _size.width * .75,
          color: Theme.of(context).primaryColor,
          child: TextButton(
            onPressed: () async => await onPressedFunction(),
            child: Text(
              labelText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
