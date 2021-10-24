import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasError;

  const RegisterFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.hasError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        border: Border.all(color: hasError ? Colors.red : Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
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
