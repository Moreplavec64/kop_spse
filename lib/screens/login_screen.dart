import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: LoginForm());
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EduPageProvider>(context);

    return (provider.getLoginStatus == LoginStatus.LoggingIn)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              TextButton(
                  onPressed: () async {
                    print('logging in');
                    if (provider.getLoginStatus != LoginStatus.LoggingIn) {
                      provider.setAuthValues('AdamHadar', '5RDVUDPSPA');
                      provider.setLoginStatus = LoginStatus.LoggingIn;
                      await provider
                          .login(useTestValues: false)
                          .then((logInStatus) {
                        if (logInStatus) {
                          provider.setLoginStatus = LoginStatus.LoggedIn;
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      });
                    }
                  },
                  child: Text('login????')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Text('Druha screena'),
              ),
              Container(
                height: 50,
                width: 50,
                color: Color(0xffffff80),
              )
            ],
          );
  }
}
