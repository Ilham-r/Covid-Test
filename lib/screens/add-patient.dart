import 'package:covidtest/components/material_button.dart';
import 'package:covidtest/screens/patients_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidtest/components/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:covidtest/constants.dart';

List<String> selected = [];

class AddPatient extends StatefulWidget {
  static const String id = 'AddPatient';
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _firestore = Firestore.instance;

  int val;
  String name;
  String LastName;

  int priority;
  int GetPriority() {
    setState(() {
      for (String item in selected) {
        if (item == 'Hospitalized' || item == 'Healthcare facility workers') {
          priority = 1;
        } else if (item == 'long-term care facilities' ||
            item == ' Underlying conditions' ||
            item == 'First responders' ||
            val >= 65) {
          priority = 2;
        } else {
          priority = 3;
        }
      }
    });
    return priority;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            'Patient add',
            textAlign: TextAlign.center,
          ),
          content: Icon(
            Icons.check_circle_outline,
            color: Colors.greenAccent,
            size: 50,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushNamed(context, PatientsScreen.id);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: KContainerDecoration,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Add Patient',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Textfield(
                    hint: 'Enter the patient Name',
                    onchanged: (value) {
                      name = value;
                    },
                    obsucuretext: false,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Textfield(
                    hint: 'Enter the patient Last Name',
                    onchanged: (value) {
                      LastName = value;
                    },
                    obsucuretext: false,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter the patient age',
                        hintStyle: TextStyle(color: Colors.white)),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      val = int.parse(value);
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        filterChip(
                          chipText: 'Hospitalized',
                        ),
                        filterChip(
                          chipText: 'First responders',
                        ),
                        filterChip(
                          chipText: 'Healthcare facility workers',
                        ),
                        filterChip(
                          chipText: 'long-term care facilities',
                        ),
                        filterChip(
                          chipText: 'Critical infrastructure workers',
                        ),
                        filterChip(
                          chipText: 'Individuals with mild symptoms',
                        ),
                        filterChip(
                          chipText: 'Underlying conditions',
                        ),
                        filterChip(
                          chipText: 'Others',
                        ),
                      ],
                    ),
                  ),
                  MatButton(
                      title: 'Add',
                      onpressed: () async {
                        priority = GetPriority();
                        await _firestore.collection('patients').add({
                          'Name': name,
                          'Last Name': LastName,
                          'age': val,
                          'priority': priority,
                          'hascovid': false
                        });
                        _showDialog();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class filterChip extends StatefulWidget {
  filterChip({this.chipText});
  String chipText;
  @override
  _filterChipState createState() => _filterChipState();
}

class _filterChipState extends State<filterChip> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipText),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      selected: _isSelected,
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          isSelected
              ? selected.add(widget.chipText)
              : selected.remove(widget.chipText);
        });
      },
      selectedColor: Colors.grey.shade400,
    );
  }
}
