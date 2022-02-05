import 'package:kop_spse/main.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_button.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_button_google.dart';
import 'package:kop_spse/widgets/login_screen_widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'input_widget.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormBody> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final eduProvider = Provider.of<EduPageProvider>(context, listen: false);
    if (eduProvider.getEduLoginStatus == LoginStatus.LoginFailed)
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: const Text('Neplatné prihlasovacie údaje do Edupage'),
          ),
        );
        eduProvider.setLoginStatus = LoginStatus.LoggedOut;
      });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .05),
      width: double.infinity,
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextInputWidget(
              size: MediaQuery.of(context).size,
              validator: (String? x) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
                        .hasMatch(x!)
                    ? null
                    : 'Email je v nesprávnom formáte';
              },
              controller: _emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 12),
            TextInputWidget(
              size: MediaQuery.of(context).size,
              validator: (String? x) {
                return RegExp(r'(.){6,}').hasMatch(x!)
                    ? null
                    : 'Heslo musí obsahovať aspoň 6 znakov';
              },
              controller: _passwordController,
              labelText: 'Heslo',
              isPassword: true,
            ),
            if (!authProvider.getLoggingIn)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Prihlasovacie údaje zhodné s EduPage',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: authProvider.getUdajeZhodne,
                      onChanged: (_) => authProvider.toggleUdajeZhodne()),
                ],
              ),
            const SizedBox(height: 24),
            LoginButton(
              loginFunction,
              authProvider.getLoggingIn ? 'Login' : 'Pokračovať',
            ),
            OrDivider(label: 'OR', height: 24),
            const LoginGoogleButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(authProvider.getLoggingIn
                    ? 'Ešte nemáte účet?'
                    : 'Už máte účet?'),
                SizedBox(
                  width: 12,
                ),
                TextButton(
                  onPressed: authProvider.toggleIsLoggingIn,
                  child: Text(
                    authProvider.getLoggingIn
                        ? 'Zaregistrujte sa'
                        : 'Prihláste sa',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginFunction() async {
    final EduPageProvider eduProvider =
        Provider.of<EduPageProvider>(context, listen: false);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final JedalenProvider jedalenProvider =
        Provider.of<JedalenProvider>(context, listen: false);
    final SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      if (eduProvider.getEduLoginStatus != LoginStatus.LoggingIn)
        eduProvider.setLoginStatus = LoginStatus.LoggingIn;
      //Prihlasenie
      if (authProvider.getLoggingIn) {
        await authProvider.login(
            eduProvider: eduProvider,
            email: _emailController.text,
            password: _passwordController.text);

        await jedalenProvider.fetchJedalenData();
        await settingsProvider.loadValues();

        if (authProvider.getLoggedIn) {
          navigationKey.currentState?.pushReplacementNamed('/home');
        }

        if (!authProvider.getLoggedIn)
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: const Text('Neplatne prihlasovacie udaje'),
              ),
            );
          });
      }
      //registracia
      else {
        authProvider.setEmailAndPass(
            _emailController.text, _passwordController.text);
        navigationKey.currentState?.pushNamed('/login2');
        eduProvider.setLoginStatus = LoginStatus.LoggedOut;
      }
    }
  }
}
