import 'package:flutter/material.dart';
import 'package:covidtest/components/text_field.dart';
import 'package:covidtest/components/material_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidtest/screens/login_screen.dart';
import 'package:covidtest/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp_Screen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignUp_ScreenState createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  String Email;
  String Password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 140, horizontal: 30),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: KContainerDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 70,
                height: 2,
                color: Colors.white,
              ),
              Textfield(
                hint: 'Enter your Email',
                onchanged: (value) {
                  Email = value;
                },
                obsucuretext: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              Textfield(
                hint: 'Enter your password',
                onchanged: (value) {
                  Password = value;
                },
                obsucuretext: true,
              ),
              MatButton(
                  title: 'sign up ',
                  onpressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: Email, password: Password);

                      if (newUser != null) {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
