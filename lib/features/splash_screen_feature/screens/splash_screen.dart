import 'dart:async';

import 'package:doctorcall/coreapp/constants/color_pallete.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if(notification!=null && androidNotification !=null){
        Navigator.pushNamed(context, Routes.SHOWNOTIF_SCREEN);
      }
    });

    super.initState();
  }

  void checkLogin() async {
    Timer(Duration(seconds: 3), () async {
      if (await SessionManagement.chekIslogin()) {
        Navigator.restorablePushReplacementNamed(context, Routes.MAIN);
      } else if(await SessionManagement.isFirstTime()) {
        Navigator.restorablePushReplacementNamed(context, Routes.ONBOARDING);
      }else{
        Navigator.restorablePushReplacementNamed(context, Routes.FIREBASE_SCREEN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          color: ColorPallete.docColorPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: Image.asset("assets/image/doctorflaction.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome to DoctotCall",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: Colors.white),
              )
            ],
          )),
    );
  }
}
