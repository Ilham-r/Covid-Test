import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidtest/components/material_button.dart';
import 'package:covidtest/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidtest/constants.dart';
import 'package:covidtest/screens/patients_screen.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String LoginEmail;
  String Passwod;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 140, horizontal: 30),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: KContainerDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Log IN',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 30),
                width: double.infinity,
                height: 2,
                color: Colors.white,
              ),
              Textfield(
                hint: 'Enter your email',
                onchanged: (value) {
                  LoginEmail = value;
                },
                obsucuretext: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              Textfield(
                hint: 'Enter your password',
                onchanged: (value) {
                  Passwod = value;
                },
                obsucuretext: true,
              ),
              MatButton(
                title: 'Log in',
                onpressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final LoggedUser = await _auth.signInWithEmailAndPassword(
                        email: LoginEmail, password: Passwod);
                    if (LoggedUser != null) {
                      Navigator.pushNamed(context, PatientsScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }

                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
