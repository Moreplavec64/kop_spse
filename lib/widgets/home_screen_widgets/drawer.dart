import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.grey[300],
      ),
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Spacer(),
              Container(
                width: 100,
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets\\images\\svk_flag.png',
                      height: size.height * .05,
                    ),
                  ),
                  SizedBox(width: 40),
                  GestureDetector(
                    child: Image.asset(
                      'assets\\images\\uk_flag.png',
                      height: size.height * .05,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Image.asset(
                'assets\\images\\logo.png',
                height: size.height * .2,
              ),
              SizedBox(
                height: size.height * .05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
