import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidtest/components/patient-card.dart';

class CovidPatient extends StatefulWidget {
  static const String id = 'covid_patient';
  @override
  _CovidPatientState createState() => _CovidPatientState();
}

class _CovidPatientState extends State<CovidPatient> {
  final _firestore = Firestore.instance;

  Color color;

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
        title: Text(
          'Covid19 Patients',
        ),
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
              if (Hascovid) {
                final PaName = patient.data['Name'];
                final PaLastName = patient.data['Last Name'];
                final priority = patient.data['priority'];

                final PatientInfo = PatientCard(
                  Name: PaName,
                  LastName: PaLastName,
                  color: PriorityColor(priority),
                  onTap: null,
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
    );
  }
}
