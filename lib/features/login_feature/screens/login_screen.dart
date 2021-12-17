import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  loginData() async{
    var url =
    Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var response = await http.get(url);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 200),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Email Id:",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Password :",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: pwdController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                RaisedButton(
                  onPressed: () async {
                    await loginData();
                  },
                  child: Text('Login'),
                  color: Colors.orange,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                // if (localStorage != null)
                //   Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Text("User Logged in!!! ->  Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}",style: TextStyle(fontSize: 20),),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
