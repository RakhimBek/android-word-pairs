import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasError;
  final bool Function(String text) validator;

  bool hasErro = false;

  RegisterFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.hasError = false,
    this.validator = trueFunction,
  }) : super(key: key);

  static bool trueFunction(String _) {
    return true;
  }

  @override
  State<StatefulWidget> createState() {
    return RegisterFormFieldState(
      controller: controller,
      hintText: hintText,
      obscureText: obscureText,
      validator: validator,
    );
  }
}

class RegisterFormFieldState extends State<StatefulWidget> {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool Function(String text) validator;
  bool isValid = false;

  RegisterFormFieldState({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  }) {
    isValid = validator(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        border: Border.all(color: isValid ? Colors.transparent : Colors.red),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        onChanged: (text) {
          setState(() {
            isValid = validator(text);
          });
        },
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
