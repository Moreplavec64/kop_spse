import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/providers/settings.dart';
import 'package:kop_spse/screens/settings_screen.dart';
import 'package:kop_spse/widgets/login_screen_widgets/input_widget.dart';
import 'package:provider/provider.dart';

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
  bool oldFirebaseAccPassCorrect = false;

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
                  validator: (x) {
                    //aplikacne heslo a ak nieje spravne
                    if (!widget.isEdu && !oldFirebaseAccPassCorrect)
                      return 'Nesprávne heslo';
                    if (widget.isEdu &&
                        !Provider.of<EduPageProvider>(context, listen: false)
                            .comparePass(x ?? '')) return 'Nesprávne heslo';
                    return null;
                  },
                  controller: stareHeslo,
                  labelText: 'Aktuálne Heslo',
                  isPassword: true,
                ),
                TextInputWidget(
                  size: MediaQuery.of(context).size,
                  validator: (String? x) {
                    if (widget.isEdu) return null;
                    return RegExp(r'(.){6,}').hasMatch(x!)
                        ? null
                        : 'Heslo musí obsahovať aspoň 6 znakov';
                  },
                  controller: noveHeslo1,
                  labelText: 'Nové Heslo',
                  isPassword: true,
                ),
                TextInputWidget(
                  size: MediaQuery.of(context).size,
                  validator: (String? x) {
                    if (noveHeslo1.text != noveHeslo2.text)
                      return 'Heslá sa nezhodujú';
                    if (widget.isEdu) return null;
                    return RegExp(r'(.){6,}').hasMatch(x!)
                        ? null
                        : 'Heslo musí obsahovať aspoň 6 znakov';
                  },
                  controller: noveHeslo2,
                  labelText: 'Zopakujte Heslo',
                  isPassword: true,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        child: Text(
                          'Zmeniť heslo',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () async {
                          dprov.toggleLoading();
                          //*skusenie prihlasenie so zadanim heslom, ak nieje korektne
                          //*hodi sa error a v onError sa ukaze snackbar a bool pre validator sa zmeni
                          if (!widget.isEdu && stareHeslo.text.isNotEmpty) {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .getEmail,
                                    password: stareHeslo.text)
                                .then((value) {
                              print(value.user);
                              oldFirebaseAccPassCorrect = value.user != null;
                            }).onError((error, __) {
                              oldFirebaseAccPassCorrect = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error.toString()),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ));
                              print(error);
                            });
                          }
                          final bool isOk = _formKey.currentState!.validate();

                          final bool confirmed = isOk
                              ? await showVerifyDialog(context,
                                      'Chcete pokračovať so zmenou hesla?') ??
                                  false
                              : false;
                          final authProv =
                              Provider.of<AuthProvider>(context, listen: false);

                          if (isOk && confirmed) {
                            if (widget.isEdu) {
                              await authProv
                                  .changeEduPass(noveHeslo2.text)
                                  .then((v) {
                                if (v) uspesneZmeneneFunction(dprov);
                              });
                            } else {
                              print(noveHeslo2.text);
                              await authProv
                                  .changePassword(noveHeslo2.text)
                                  .then((v) {
                                if (v) uspesneZmeneneFunction(dprov);
                              });
                            }
                          }
                          dprov.toggleLoading();
                          // setState(() {});
                        }))
              ],
            ),
          ),
      ],
    );
  }

  void uspesneZmeneneFunction(SettingsProvider dprov) {
    stareHeslo.clear();
    noveHeslo1.clear();
    noveHeslo2.clear();
    widget.isEdu
        ? dprov.toggleIsChangingEduPass()
        : dprov.toggleIsChangingPass();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Heslo bolo úspešne zmenené'),
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }
}
