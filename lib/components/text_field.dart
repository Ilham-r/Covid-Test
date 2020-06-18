import 'package:flutter/material.dart';
import 'package:covidtest/constants.dart';

class Textfield extends StatelessWidget {
  Textfield({this.hint, @required this.onchanged, this.obsucuretext});
  String hint;
  Function onchanged;
  bool obsucuretext = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      obscureText: obsucuretext,
      onChanged: onchanged,
      textAlign: TextAlign.center,
      decoration: kTextFieldDecoration.copyWith(
        contentPadding: EdgeInsets.all(4.0),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
