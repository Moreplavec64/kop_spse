import 'package:flutter/material.dart';

class LoginScreenVzor extends StatelessWidget {
  Widget build(BuildContext context) {
    print("Redux: Login rebuild");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * .35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.elliptical(size.width * .5, size.height * .05),
                    bottomRight:
                        Radius.elliptical(size.width * .5, size.height * .05),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello',
                        style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text('Login in to your account',
                        style: TextStyle(fontSize: 16, color: Colors.white))
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
