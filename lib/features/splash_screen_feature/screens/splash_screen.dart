import 'dart:async';

import 'package:doctorcall/coreapp/constants/color_pallete.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5),() => Navigator.restorablePushReplacementNamed(context, Routes.ONBOARDING));
    super.initState();
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
