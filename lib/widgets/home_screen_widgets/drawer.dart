import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isSlovak = true;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey[300]),
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Row(children: [
                Icon(
                  Icons.settings_outlined,
                  size: 32,
                ),
                Text(
                  'Nastavenia',
                  style: TextStyle(fontSize: 24),
                ),
              ]),
              Row(children: [
                Icon(
                  Icons.school_outlined,
                  size: 32,
                ),
                Text(
                  'Stránka školy',
                  style: TextStyle(fontSize: 24),
                ),
              ]),
              Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      if (isSlovak)
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 5)),
                          child: GestureDetector(
                            child: Image.asset(
                              'assets\\images\\svk_flag.png',
                              height: size.height * .05,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets\\images\\uk_flag.png',
                        height: size.height * .05,
                      ),
                    ),
                  ),
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
