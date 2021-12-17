import 'package:doctorcall/features/boarding_feature/boarding_screen.dart';
import 'package:doctorcall/features/doctor_feature/screens/doctor_screen.dart';
import 'package:doctorcall/features/login_feature/screens/login_screen.dart';
import 'package:doctorcall/features/main_page_feature/screens/main_screen.dart';
import 'package:doctorcall/features/register_feature/screens/register_screen.dart';
import 'package:doctorcall/features/splash_screen_feature/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ROOT:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case Routes.LOGIN:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case Routes.REGISTER:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case Routes.MAIN:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case Routes.ONBOARDING:
      return MaterialPageRoute(builder: (context) => BordingScreen());
    case Routes.DOCTOR:
      String _doctorName = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => DoctorScreen(doctorName: _doctorName,));
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
