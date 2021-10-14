import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          size: size,
        ),
        body: LoginForm());
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
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text(';ksljdflksjadlkf;sdlkjf'))
            ],
          );
  }
}

Future<void> login({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  final UserProvider userProvider = Provider.of<UserProvider>(context);
  await userProvider.loginEmail(email, password);

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Map<String, dynamic> data = await users
      .doc(userProvider.getUID.toString())
      .get() as Map<String, dynamic>;

  Provider.of<EduPageProvider>(context).setAuthValues(
    data['eduUsername'],
    data['eduPassword'],
  );
  await Provider.of<EduPageProvider>(context).login();
}
