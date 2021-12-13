import 'package:doctorcall/coreapp/routing/routes.dart';
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
        child: IconButton(icon: Icon(Icons.save),
          onPressed: (){
          Navigator.pushNamed(context, Routes.DOCTOR, arguments: "dr. Anne");
          },
        ),
      ),
    );
  }
}
