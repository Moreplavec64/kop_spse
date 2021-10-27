import 'package:flutter/material.dart';
import 'package:kop_spse/widgets/login_screen_widgets/input_widget.dart';

class SecondLoginForm extends StatefulWidget {
  const SecondLoginForm({Key? key}) : super(key: key);

  @override
  State<SecondLoginForm> createState() => _SecondLoginFormState();
}

class _SecondLoginFormState extends State<SecondLoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Form(
        child: Column(
          children: [
            TextInputWidget(
                size: _size,
                validator: (x) => null,
                controller: _emailController,
                labelText: 'Username alebo email z EduPage'),
            TextInputWidget(
                size: _size,
                validator: (x) => null,
                controller: _passwordController,
                labelText: 'Heslo k EduPage')
          ],
        ),
      ),
    );
  }
}
