import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                child: Text('login????'),
              ),
              LoginFormBody(),
            ],
          );
  }
}

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextInputWidget(
            size: MediaQuery.of(context).size,
            validator: (String? x) {
              return null;
            },
            controller: _userNameController,
            labelText: 'Prihlasovacie meno alebo Email',
          ),
          SizedBox(
            height: 12,
          ),
          _buildTextInputWidget(
            size: MediaQuery.of(context).size,
            validator: (String? x) {
              return null;
            },
            controller: _passwordController,
            labelText: 'Heslo',
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Meno : ' + _userNameController.value.text);
                print('heslo : ' + _passwordController.value.text);
              }
            },
            child: Text('Subnittttttts'),
          )
        ],
      ),
    );
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

    Provider.of<EduPageProvider>(context, listen: false).setAuthValues(
      data['eduUsername'],
      data['eduPassword'],
    );
    await Provider.of<EduPageProvider>(context).login();
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
