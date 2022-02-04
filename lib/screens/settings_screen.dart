import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/widgets/appbar.dart';
import 'package:kop_spse/widgets/home_screen_widgets/drawer.dart';
import 'package:kop_spse/widgets/login_screen_widgets/input_widget.dart';
import 'package:kop_spse/widgets/setting_screen_widgets/podlaziaButton.dart';
import 'package:kop_spse/widgets/setting_screen_widgets/settingKategoriaTitle.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static String route = "/homeScreen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _size = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight);
    final SettingsProvider provider = Provider.of<SettingsProvider>(context);

    return Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          size: MediaQuery.of(context).size,
        ),
        drawer: const CustomDrawer(),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                          Text('Zobraziť názvy učební'),
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
                          Text('Predvolene zobrazené poschodie'),
                          PodlazieDropDownSettingButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vymazať históriu vyhľadávania'),
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              splashColor: Colors.red.withOpacity(1),
                            ),
                          )
                        ],
                      ),
                    ),
                    SettingKategoriaTitle(title: 'ÚČET'),
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
                      child: Text('xxxxxxx'),
                      onPressed: () {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .loadValues();
                      },
                    ),
                  ],
                ),
              ));
  }
}

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({
    Key? key,
    required this.title,
    required this.isEdu,
  }) : super(key: key);

  final String title;
  final bool isEdu;

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final TextEditingController stareHeslo = TextEditingController();
  final TextEditingController noveHeslo1 = TextEditingController();
  final TextEditingController noveHeslo2 = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool oldAccPassCorrect = false;

  @override
  void dispose() {
    super.dispose();
    stareHeslo.dispose();
    noveHeslo1.dispose();
    noveHeslo2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dprov = Provider.of<SettingsProvider>(context, listen: false);
    final bool isExpanded =
        widget.isEdu ? dprov.isChangingEduPass : dprov.isChangingPass;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            ExpandIcon(
              padding: EdgeInsets.all(0),
              onPressed: (value) {
                widget.isEdu
                    ? dprov.toggleIsChangingEduPass()
                    : dprov.toggleIsChangingPass();
                // setState(() {});
              },
              isExpanded: isExpanded,
            ),
          ],
        ),
        if (isExpanded)
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextInputWidget(
                  size: MediaQuery.of(context).size,
                  validator: (X) {},
                  controller: stareHeslo,
                  labelText: 'Aktualne Heslo',
                  isPassword: true,
                ),
                TextInputWidget(
                  size: MediaQuery.of(context).size,
                  validator: (String? x) {
                    return RegExp(r'(.){6,}').hasMatch(x!)
                        ? null
                        : 'Heslo musí obsahovať aspoň 6 znakov';
                  },
                  controller: noveHeslo1,
                  labelText: 'Nove Heslo',
                  isPassword: true,
                ),
                TextInputWidget(
                  size: MediaQuery.of(context).size,
                  validator: (String? x) {
                    return RegExp(r'(.){6,}').hasMatch(x!)
                        ? null
                        : 'Heslo musí obsahovať aspoň 6 znakov';
                  },
                  controller: noveHeslo2,
                  labelText: 'Zopakuj Heslo',
                  isPassword: true,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(Icons.check_circle),
                        onPressed: () async {
                          if (!widget.isEdu && stareHeslo.text.isNotEmpty) {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .getEmail,
                                    password: stareHeslo.text)
                                .then((value) =>
                                    oldAccPassCorrect = value.user != null);
                          }
                          final bool isOk = _formKey.currentState!.validate();
                          print(isOk);
                        }))
              ],
            ),
          ),
      ],
    );
  }
}
