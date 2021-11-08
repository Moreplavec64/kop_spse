import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      width: size.width * .66,
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[200]),
        child: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 40,
                    color: Colors.grey[800],
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height: size.height * .05),
                DrawerButton(
                  text: 'Školská stránka',
                  onTap: () async {
                    final _url = 'https://spojenaskolanz.edupage.org/';
                    await canLaunch(_url)
                        ? await launch(_url)
                        : throw 'Could not launch $_url';
                  },
                  icon: Icons.school_outlined,
                ),
                DrawerButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/home/settings'),
                    icon: Icons.settings_outlined,
                    text: 'Nastavenia'),
                DrawerButton(
                  onTap: () {
                    final auth =
                        Provider.of<AuthProvider>(context, listen: false);
                    Provider.of<EduPageProvider>(context, listen: false)
                        .setLoginStatus = LoginStatus.LoggedOut;

                    auth.setLoggedIn = false;
                    if (!auth.getLoggingIn) auth.toggleIsLoggingIn();

                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  icon: Icons.logout,
                  text: 'Odhlásiť sa',
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => authProvider.setLang = 'SVK',
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: authProvider.getCurrentLang == 'SVK' ? 5 : 0,
                          ),
                        ),
                        child: Image.asset(
                          'assets\\images\\svk_flag.png',
                          height: size.height * .05,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => authProvider.setLang = 'ANJ',
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: authProvider.getCurrentLang == 'SVK' ? 0 : 5,
                          ),
                        ),
                        child: Image.asset(
                          'assets\\images\\uk_flag.png',
                          height: size.height * .05,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .1),
                Image.asset(
                  'assets\\images\\logo.png',
                  height: size.height * .15,
                ),
                SizedBox(height: size.height * .05)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
      child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                size: 36,
                color: Color(0xff434343),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff434343),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )),
    );
  }
}
