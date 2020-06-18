import 'package:flutter/material.dart';

const KContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
//bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(20.0)),
  color: Color(0xFF9CE0E0),
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        //bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFD8F9C), width: 1.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        //bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFD8F9C), width: 2.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        //bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(20.0)),
  ),
);
