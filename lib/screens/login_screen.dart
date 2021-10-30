import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/widgets/login_screen_widgets/loginForm.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eduProvider = Provider.of<EduPageProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: (eduProvider.getEduLoginStatus == LoginStatus.LoggingIn ||
                authProvider.getLoggedIn)
            ? Center(
                child: const CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * .35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(
                              size.width * .5, size.height * .05),
                          bottomRight: Radius.elliptical(
                              size.width * .5, size.height * .05),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Vitajte',
                              style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(
                              authProvider.getLoggingIn
                                  ? 'Prihláste sa do svojho účtu'
                                  : 'Vyvorte si nový účet',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    const LoginFormBody(),
                  ],
                ),
              ),
      ),
    );
  }
}
