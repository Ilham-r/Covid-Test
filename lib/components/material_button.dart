import 'package:flutter/material.dart';

class MatButton extends StatelessWidget {
  MatButton({@required this.title, @required this.onpressed});
  String title;

  Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: Color(0xFFFD8F9C),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
