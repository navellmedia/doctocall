import 'dart:convert';

import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/features/login_feature/models/login_response.dart';
import 'package:doctorcall/features/login_feature/models/news_respose.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? token;

  login() async {
    var client = http.Client();
    var url = Uri.https('presline-api.navel.id', '/api/login');
    var res = await client.post(url,
        headers: {"Content-Type": "Application/JSON"},
        body: jsonEncode({"email": "inte@gmail.com", "password": "12345678"}));

    if (res.statusCode == 200 || res.statusCode == 400) {
      var loginResponse = loginResponseFromJson(res.body);
      if (loginResponse.success!) {
        setState(() {
          token = "Bearer ${loginResponse.token}";
        });

        print(loginResponse.token);
      } else {
        print(loginResponse.message);
      }
    } else {
      print("login failed error code : ${res.statusCode}");
    }
  }

  void getNews() async {
    var client = http.Client();
    var url = Uri.https('presline-api.navel.id', '/api/getnews');
    var res = await client.get(
      url,
      headers: {"Authorization": token!},
    );
    var _news = newsResponseFromJson(res.body);
    if (_news.data!.length > 0) {
      _news.data!.forEach((element) {
        print(element.title);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: ListView(
          children: [
            RaisedButton(
              onPressed: () {
                //Navigator.pushReplacementNamed(context, Routes.MAIN);
                login();
              },
              child: Text("go to main screnn"),
            ),
            RaisedButton(
              onPressed: () {
                getNews();
              },
              child: Text("Get News"),
            )
          ],
        ));
  }
}
