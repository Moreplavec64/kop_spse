import 'package:kop_spse/providers/auth.dart';
import 'package:kop_spse/providers/edupage.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_button.dart';
import 'package:kop_spse/widgets/login_screen_widgets/login_button_google.dart';
import 'package:kop_spse/widgets/login_screen_widgets/or_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormBody> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormBody> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final GlobalKey<FormState> _formKey;

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (Provider.of<EduPageProvider>(context, listen: false)
              .getEduLoginStatus ==
          LoginStatus.LoginFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: const Text('Neplatne prihlasovacie udaje do Edupage'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EduPageProvider>(context, listen: false);
    final authProvider = Provider.of<UserProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .05),
      width: double.infinity,
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextInputWidget(
              size: MediaQuery.of(context).size,
              validator: (String? x) {
                return null;
              },
              controller: _userNameController,
              labelText: 'Prihlasovacie meno alebo Email',
            ),
            const SizedBox(height: 12),
            _buildTextInputWidget(
              size: MediaQuery.of(context).size,
              validator: (String? x) {
                return null;
              },
              controller: _passwordController,
              labelText: 'Heslo',
              isPassword: true,
            ),
            if (!authProvider.getLoggingIn)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Prihlasovacie údaje zhodné s EduPage',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: authProvider.getUdajeZhodne,
                      onChanged: (_) => authProvider.toggleUdajeZhodne()),
                ],
              ),
            const SizedBox(height: 24),
            LoginButton(
              () {
                if (_formKey.currentState!.validate()) {
                  print('Meno : ' + _userNameController.value.text);
                  print('heslo : ' + _passwordController.value.text);
                  if (provider.getEduLoginStatus != LoginStatus.LoggingIn)
                    provider.setLoginStatus = LoginStatus.LoggingIn;

                  Provider.of<EduPageProvider>(context, listen: false)
                      .setAuthValues(
                    _userNameController.value.text,
                    _passwordController.value.text,
                  );
                  Provider.of<EduPageProvider>(context, listen: false).login();
                }
              },
              authProvider.getLoggingIn ? 'Login' : 'Register',
            ),
            OrDivider(label: 'OR', height: 24),
            LoginGoogleButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account yet?'),
                SizedBox(
                  width: 12,
                ),
                TextButton(
                  onPressed: authProvider.toggleIsLoggingIn,
                  child: Text(
                    'Click here',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.loginEmail(email, password);

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final Map<String, dynamic> data = await users
        .doc(userProvider.getUID.toString())
        .get() as Map<String, dynamic>;

    Provider.of<EduPageProvider>(context, listen: false).setAuthValues(
      data['eduUsername'],
      data['eduPassword'],
    );
    if (Provider.of<EduPageProvider>(context, listen: false)
            .getEduLoginStatus !=
        LoginStatus.LoggedIn)
      await Provider.of<EduPageProvider>(context).login();
  }

  Future<void> register({
    required BuildContext context,
    required String email,
    required String password,
    required String eduUser,
    required String eduPassword,
  }) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final UserProvider authProvider =
        Provider.of<UserProvider>(context, listen: false);
    final EduPageProvider eduProvider = Provider.of<EduPageProvider>(context);

    await userProvider.registerEmail(email, password);

    eduProvider.setAuthValues(eduUser, eduPassword);
    //TODO verify edupage login data
    await eduProvider.login();

    authProvider.createDataAfterReg(eduUser, eduPassword);

    login(context: context, email: email, password: password);
  }
}

Container _buildTextInputWidget({
  required Size size,
  required validator,
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
  bool isPassword = false,
  bool isLast = false,
}) {
  return Container(
    width: size.width * .8,
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12, right: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: InputBorder.none,
          hintText: labelText,
        ),
        style: TextStyle(fontSize: 17),
        obscureText: isPassword ? true : false,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      ),
    ),
  );
}
