import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_button.dart';
import 'package:kop_spse/widgets/login_screen_widgets/second_login_form.dart';

class SecondLoginScreen extends StatelessWidget {
  const SecondLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _fullSize = MediaQuery.of(context).size;
    final _size = Size(_fullSize.width,
        _fullSize.height - MediaQuery.of(context).padding.vertical);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: Column(
                children: [
                  Container(
                    height: _size.height * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //back arrow
                        Container(
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(flex: 1),
                        Container(
                          child: Text(
                            'Doplňte daľšie údaje',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    constraints: BoxConstraints.tight(
                      Size(double.infinity, _size.height * .8),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                          _size.width * .5,
                          _size.height * .05,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Prihlasovacie údaje do EduPage',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SecondLoginForm(),
                        const Spacer(flex: 1),
                        Text(
                          'Predvolený jazyk',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
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
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 0)),
                                child: GestureDetector(
                                  child: Image.asset(
                                    'assets\\images\\uk_flag.png',
                                    height: size.height * .05,
                                  ),
                                ),
                              ),
                            ]),
                        const Spacer(flex: 2),
                        LoginButton(
                          () async {},
                          'Zaregistrovať',
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

    /*Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: size.width,
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Vyberte svoj predvolený jazyk a zadajte prihlasovacie údaje do EduPage',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(height: 12),
              const SecondLoginForm(),
            ],
          ),
        ),
      ),
    );*/

