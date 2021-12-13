import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: ListView(
        children: [
          RaisedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, Routes.MAIN);
          }, child: Text("go to main screnn"),)
        ],
      )
    );
  }
}
