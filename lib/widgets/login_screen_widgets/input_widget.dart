import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.size,
    required this.validator,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isLast = false,
  }) : super(key: key);

  final Size size;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
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
}
