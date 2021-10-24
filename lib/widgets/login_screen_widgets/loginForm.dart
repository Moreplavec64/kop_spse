import 'package:kop_spse/providers/user.dart';
import 'package:kop_spse/providers/edupage.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (Provider.of<EduPageProvider>(context, listen: false)
              .getEduLoginStatus ==
          LoginStatus.LoginFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: const Text('Neplatne prihlasovacie udaje do Edupage'),
          ),
        );
        Provider.of<EduPageProvider>(context, listen: false).setLoginStatus =
            LoginStatus.LoggedOut;
      }
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
    final provider = Provider.of<EduPageProvider>(context, listen: false);
    final authProvider = Provider.of<UserProvider>(context);

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
              () async {
                if (_formKey.currentState!.validate()) {
                  final UserProvider _userProv =
                      Provider.of<UserProvider>(context, listen: false);

                  if (provider.getEduLoginStatus != LoginStatus.LoggingIn) {
                    provider.setLoginStatus = LoginStatus.LoggingIn;
                  }
                  if (_userProv.getLoggingIn)
                    await _userProv.login(
                        eduProvider: provider,
                        email: _emailController.text,
                        password: _passwordController.text);
                  else
                    await _userProv
                        .register(
                            eduProvider: provider,
                            email: _emailController.text,
                            password: _passwordController.text,
                            eduUser: 'adamhadar',
                            eduPassword: '5rdvudpspa')
                        .then(
                          (_) async => await _userProv.login(
                              eduProvider: provider,
                              email: _emailController.text,
                              password: _passwordController.text),
                        );
                }
              },
              authProvider.getLoggingIn ? 'Login' : 'Register',
            ),
            OrDivider(label: 'OR', height: 24),
            LoginGoogleButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account yet?'),
                SizedBox(
                  width: 12,
                ),
                TextButton(
                  onPressed: authProvider.toggleIsLoggingIn,
                  child: Text(
                    'Click here',
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
}
