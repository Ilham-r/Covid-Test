import 'package:covidtest/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add-patient.dart';
import 'package:covidtest/components/patient-card.dart';
import 'covid_patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientsScreen extends StatefulWidget {
  static const String id = 'patients_screen';
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final _firestore = Firestore.instance;

  Color color;
  void _showDialog(
    var ID,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Patient test results',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'The test results of this patient is',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Positive'),
                onPressed: () async {
                  await _firestore
                      .collection('patients')
                      .document(ID)
                      .updateData({
                    'hascovid': true,
                  });
                  Navigator.of(context).pop();
                }),
            SizedBox(width: 70),
            FlatButton(
                child: Text('Negative'),
                onPressed: () async {
                  await _firestore.collection('patients').document(ID).delete();
                }),
          ],
        );
      },
    );
  }

  Color PriorityColor(int priority) {
    if (priority == 1) {
      return color = Colors.redAccent;
    } else if (priority == 2) {
      return color = Colors.orangeAccent;
    } else {
      return color = Colors.yellowAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                size: 30.0,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        backgroundColor: Color(0xFF9CE0E0),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              _firestore.collection('patients').orderBy("priority").snapshots(),
          builder: (context, snapshot) {
            final patients = snapshot.data.documents;
            List<PatientCard> PatientsList = [];

            for (var patient in patients) {
              final Hascovid = patient.data['hascovid'];
              if (!Hascovid) {
                final PaName = patient.data['Name'];
                final PaLastName = patient.data['Last Name'];
                final priority = patient.data['priority'];
                final PatientID = patient.documentID;

                final PatientInfo = PatientCard(
                  Name: PaName,
                  LastName: PaLastName,
                  color: PriorityColor(priority),
                  onTap: () {
                    _showDialog(PatientID);
                  },
                );

                PatientsList.add(PatientInfo);
              }
            }

            return ListView(
              children: PatientsList,
            );
          },
        ),
      ),
      //
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person_add,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddPatient.id);
                }),
            Container(
              width: 2,
              height: 45,
              color: Colors.white,
            ),
            IconButton(
                icon: Icon(
                  Icons.local_hospital,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CovidPatient.id);
                }),
          ],
        ),
        color: Color(0xFF9CE0E0),
        //Color(0xFFF8B0A0),
      ),
    );
  }
}
