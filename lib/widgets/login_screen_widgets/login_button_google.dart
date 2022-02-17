import 'package:flutter/material.dart';
import 'package:kop_spse/main.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/jedalen.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:provider/provider.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height =
        (_size.height * .08 < 40 ? _size.height * .08 : 40).toDouble();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      //zaoblenie aj containeru aj flatButtonu
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: _height,
          width: _size.width * .55,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: true == false
              ? Center(child: const CircularProgressIndicator())
              : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Provider.of<EduPageProvider>(context, listen: false)
                          .setLoginStatus = LoginStatus.LoggingIn;

                      final isNew = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .continueWithGoogle(
                        eduProvider: Provider.of<EduPageProvider>(context,
                            listen: false),
                      );
                      //wait for jedalen data to be fetched
                      await Provider.of<JedalenProvider>(context, listen: false)
                          .fetchJedalenData();
                      await Provider.of<SettingsProvider>(context,
                              listen: false)
                          .loadValues();
                      if (isNew)
                        navigationKey.currentState!
                            .pushReplacementNamed('/login2');
                      else
                        navigationKey.currentState!
                            .pushReplacementNamed('/home');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets\\images\\google_logo.png',
                          height: (_height / 2).toDouble(),
                        ),
                        SizedBox(width: _size.width * .02),
                        Text(
                          'Continue with Google',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
