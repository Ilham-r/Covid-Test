import 'package:flutter/material.dart';
import 'package:covidtest/constants.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    @required this.Name,
    @required this.LastName,
    this.color,
    @required this.onTap,
  });

  final String Name;
  final String LastName;
  final Function onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            border: Border(
              left: BorderSide(
                width: 4,
                color: color,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Text(
            '$Name $LastName',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
