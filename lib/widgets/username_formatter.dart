import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsernameFormatter extends TextInputFormatter {
  final BuildContext context;
  final regExp = RegExp(r'^[a-z0-9]*$');

  UsernameFormatter(this.context);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text('hvbh'),
        duration: Duration(seconds: 5),
      ),
    );

    //Flushbar(
    //  message: 'Only lowercase English letters and digits allowed',
    //  duration: Duration(seconds: 5),
    //  messageColor: Colors.white,
    //  backgroundColor: Colors.transparent,
    //).show(context);
    return oldValue;
  }
}
