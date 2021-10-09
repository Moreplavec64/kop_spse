import 'package:flutter/material.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                final provider =
                    Provider.of<EduPageProvider>(context, listen: false);
                print('logging in');
                print(provider.getIsLogin);
                if (!provider.getIsLogin) {
                  provider.setIsLogin = true;
                  provider.setAuthValues('AdamHadar', '5RDVUDPSPA');
                  provider.login(useTestValues: true);
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
      ),
    );
  }
}
