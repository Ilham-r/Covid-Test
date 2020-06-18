import 'package:covidtest/screens/signup_screen.dart';
import 'package:covidtest/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidtest/components/material_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/lab4.jpg"),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MatButton(
                title: 'Sign up',
                onpressed: () {
                  Navigator.pushNamed(context, SignUp_Screen.id);
                }),
            MatButton(
                title: 'Log in',
                onpressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
