import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eduProvider = Provider.of<EduPageProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoading = (eduProvider.getEduLoginStatus == LoginStatus.LoggingIn ||
        authProvider.getLoggedIn);

    return GestureDetector(
      onTap: () {
        if (!isLoading) FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
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
                        const Text('Vitajte',
                            style: const TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(
                            authProvider.getLoggingIn
                                ? 'Prihláste sa do svojho účtu'
                                : 'Vyvorte si nový účet',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  LoginFormBody(),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(.6),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
