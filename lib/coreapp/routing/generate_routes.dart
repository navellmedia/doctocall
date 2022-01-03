import 'package:doctorcall/features/boarding_feature/screens/boarding_feature.dart';
import 'package:doctorcall/features/doctor_feature/screens/doctor_screen.dart';
import 'package:doctorcall/features/login_feature/screens/login_screen.dart';
import 'package:doctorcall/features/main_page_feature/screens/main_screen.dart';
import 'package:doctorcall/features/news_feature/screens/news_detail_screen.dart';
import 'package:doctorcall/features/notification_feature/screens/notification_add_screen.dart';
import 'package:doctorcall/features/register_feature/screens/register_screen.dart';
import 'package:doctorcall/features/splash_screen_feature/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ROOT:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case Routes.ONBOARDING:
      return MaterialPageRoute(builder: (context) => BoardingFeature());
    case Routes.LOGIN:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case Routes.REGISTER:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case Routes.MAIN:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case Routes.DOCTOR:
      String _doctorName = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => DoctorScreen(
                doctorName: _doctorName,
              ));
    case Routes.NEWS_DETAIL:
      dynamic argData = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => NewsDetailScreen(
                data: argData,
              ));

    case Routes.ADD_NOTIF_DATA:
      dynamic argData = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => NotificationAddScreen(
                data: argData,
              ));

    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
