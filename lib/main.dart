import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/patients_screen.dart';
import 'screens/add-patient.dart';
import 'screens/covid_patient.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        onGenerateRoute: (RouteSettings routeSettings) {
          return new PageRouteBuilder<dynamic>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                switch (routeSettings.name) {
                  case WelcomeScreen.id:
                    return WelcomeScreen();
                  case LoginScreen.id:
                    return LoginScreen();
                  case SignUp_Screen.id:
                    return SignUp_Screen();
                  case PatientsScreen.id:
                    return PatientsScreen();
                  case CovidPatient.id:
                    return CovidPatient();
                  case AddPatient.id:
                    return AddPatient();
                  default:
                    return null;
                }
              },
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return effectMap[PageTransitionType.slideInLeft](
                    Curves.linear, animation, secondaryAnimation, child);
              });
        });
  }
}
