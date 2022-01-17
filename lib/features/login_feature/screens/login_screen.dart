import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/login_feature/models/login_request.dart';
import 'package:doctorcall/features/login_feature/models/login_response.dart';
import 'package:doctorcall/features/login_feature/models/news_respose.dart';
import 'package:doctorcall/features/login_feature/models/users.dart';
import 'package:doctorcall/features/login_feature/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences? _prefs;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? token;
  bool isLoading = false;
  String _username = "";
  String _password = "";

  login() async {
    setState(() {
      isLoading = true;
    });
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
    isLoading = false;
  }

  //"inte@gmail.com"
  //"123456780000"

  void dioLogin(BuildContext context) async {
    var param = LogiRequest(email: _username, password: _password);
    var data = await LoginRepository.getLoginDataHttp(param);

    print(data.toString());
    bool isSuccess = data?.success ?? false;
    if (!isSuccess) {
      final snackBar =
          SnackBar(content: Text(data?.message ?? "Error while login"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else {
      SessionManagement.setLogin(data!.token!);
      LoginRepository.setUserData();
      Navigator.pushReplacementNamed(context, Routes.MAIN);
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
  void initState() {
    initPref();
    super.initState();
  }

  initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            TextField(
              onChanged: (val) {
                _username = val;
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.supervisor_account),
                  hintText: "Username/email",
                  border: InputBorder.none),
            ),
            TextField(
              onChanged: (val) {
                _password = val;
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "Password",
                  border: InputBorder.none),
            ),
            TextButton(
              onPressed: addUser,
              child: Text(
                "Add User",
              ),
            ),
            TextButton(
              onPressed: getData,
              child: Text(
                "Get data",
              ),
            ),
            isLoading
                ? Container()
                : RaisedButton(
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, Routes.MAIN);
                      login();
                    },
                    child: Text("Login"),
                  ),
            RaisedButton(
              onPressed: () {
                getNews();
              },
              child: Text("Get News"),
            ),
            RaisedButton(
              onPressed: () {
                dioLogin(context);
              },
              child: Text("Get Dio Login"),
            )
          ],
        ));
  }

  Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': "Jacki Chan", // John Doe
          'company': "MD", // Stokes and Sons
          'age': 26 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getData() async {
    QuerySnapshot result = await users.get();

    List<Users> iList = [];
    result.docs.forEach((element) {
      var a = element as DocumentSnapshot<Map<String,dynamic>>;
      print(a.data());
      var user = Users.fromDocumentSnapshot(doc: element as DocumentSnapshot<Map<String,dynamic>>);
      iList.add(user);
    });
  }

}
