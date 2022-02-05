import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:provider/provider.dart';

import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/setting_screen_widgets/podlaziaButton.dart';
import 'package:kop_spse/widgets/setting_screen_widgets/resetPasswordWidget.dart';
import 'package:kop_spse/widgets/setting_screen_widgets/settingKategoriaTitle.dart';

class SettingsScreen extends StatelessWidget {
  static String route = "/homeScreen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          size: MediaQuery.of(context).size,
        ),
        drawer: const CustomDrawer(),
        body: IgnorePointer(
          ignoring: provider.isLoading,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SettingKategoriaTitle(title: 'MAPY'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Zobraziť názvy učební'),
                          Switch.adaptive(
                            value: provider.getShowNazvy,
                            onChanged: (v) => provider.setShowNazvy = v,
                            activeColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Predvolene zobrazené poschodie'),
                          const PodlazieDropDownSettingButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Vymazať históriu vyhľadávania'),
                          Material(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () async {
                                bool should = await showVerifyDialog(
                                      context,
                                      'Chcete pokračovať s vymazaním histórie vyhľadávania?',
                                    ) ??
                                    false;
                                if (should) provider.recentSearch = [];
                                print(should);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              splashColor: Colors.red.withOpacity(1),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SettingKategoriaTitle(title: 'ÚČET'),
                    if (!Provider.of<AuthProvider>(context, listen: false)
                        .isGoogleUser())
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: ResetPasswordWidget(
                          title: 'Zmena hesla od aplikačného účtu',
                          isEdu: false,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: ResetPasswordWidget(
                        title: 'Zmena hesla od EduPage',
                        isEdu: true,
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('xxxxxxx'),
                      onPressed: () {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .loadValues();
                      },
                    ),
                  ],
                ),
              ),
              if (provider.isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showVerifyDialog(BuildContext context, String title) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Container(
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Áno')),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).errorColor)),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Nie')),
                ],
              )
            ],
          ),
        )),
  );
}
