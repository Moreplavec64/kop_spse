import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height =
        (_size.height * .08 < 40 ? _size.height * .08 : 40).toDouble();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      //zaoblenie aj containeru aj flatButtonu
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: _height,
          width: _size.width * .55,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: true == false
              ? Center(child: CircularProgressIndicator())
              : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            'assets\\images\\google_logo.png',
                            height: (_height / 2).toDouble(),
                          ),
                          SizedBox(width: _size.width * .02),
                          Text(
                            'Continue with Google',
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ),
        ),
      ),
    );
  }
}
