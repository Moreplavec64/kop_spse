import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/widgets/login_screen_widgets/second_login_form.dart';
import 'package:provider/provider.dart';

class SecondLoginScreen extends StatelessWidget {
  const SecondLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  SecondLoginForm(size: _size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  const LangButton({
    Key? key,
    required this.lang,
    required this.imgPath,
  }) : super(key: key);

  final String lang;
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>
          Provider.of<AuthProvider>(context, listen: false).setLang = lang,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: Provider.of<AuthProvider>(context).getCurrentLang == lang
                ? 5
                : 0,
          ),
        ),
        child: GestureDetector(
          child: Image.asset(
            imgPath,
            height: size.height * .05,
          ),
        ),
      ),
    );
  }
}
