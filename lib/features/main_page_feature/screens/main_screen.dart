import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OKE"),),
      body: Center(
        child: Column(
          children: [
            IconButton(icon: Icon(Icons.save),
              onPressed: (){
                Navigator.pushNamed(context, Routes.DOCTOR, arguments: "dr. Anne");
              },
            ),
            IconButton(icon: Icon(Icons.lock),
              onPressed: () async {
                await SessionManagement.setLogout();
                Navigator.pushNamed(context, Routes.LOGIN);
              },
            ),
          ],
        )
      ),
    );
  }
}
