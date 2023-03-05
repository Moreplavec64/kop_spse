import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/screens/second_login_screen.dart';
import 'package:kop_spse/widgets/login_screen_widgets/input_widget.dart';
import 'package:provider/provider.dart';

import 'login_button.dart';

class SecondLoginForm extends StatefulWidget {
  final Size size;

  const SecondLoginForm({Key? key, required this.size}) : super(key: key);

  @override
  State<SecondLoginForm> createState() => _SecondLoginFormState();
}

class _SecondLoginFormState extends State<SecondLoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      constraints: BoxConstraints.tight(
        Size(double.infinity, widget.size.height * .8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(
            widget.size.width * .5,
            widget.size.height * .05,
          ),
        ),
      ),
      child: Column(
        children: [
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Prihlasovacie údaje do EduPage',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputWidget(
                    size: widget.size,
                    validator: (x) => null,
                    controller: _emailController,
                    labelText: 'Username alebo email z EduPage',
                  ),
                  TextInputWidget(
                    isPassword: true,
                    size: widget.size,
                    validator: (x) => null,
                    controller: _passwordController,
                    labelText: 'Heslo k EduPage',
                  )
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Predvolený jazyk',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            LangButton(
              lang: 'SVK',
              imgPath: 'assets\\images\\svk_flag.png',
            ),
            LangButton(
              lang: 'ENG',
              imgPath: 'assets\\images\\uk_flag.png',
            ),
          ]),
          const Spacer(flex: 2),
          LoginButton(
            () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                final eduProv =
                    Provider.of<EduPageProvider>(context, listen: false);
                final authProv =
                    Provider.of<AuthProvider>(context, listen: false);
                if (eduProv.getEduLoginStatus != LoginStatus.LoggingIn)
                  eduProv.setLoginStatus = LoginStatus.LoggingIn;
                await authProv.register(
                  eduProvider: eduProv,
                  eduUser: _emailController.text,
                  eduPassword: _passwordController.text,
                  lang: authProv.getCurrentLang,
                );
                if (eduProv.getEduLoginStatus == LoginStatus.LoginFailed) {
                  eduProv.setLoginStatus = LoginStatus.LoggedOut;
                  authProv.setLoggedIn = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: const Text('Chyba pri prihlasovaní'),
                    ),
                  );
                  return;
                }
                await Provider.of<JedalenProvider>(context, listen: false)
                    .fetchJedalenData();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              }
            },
            'Zaregistrovať',
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
