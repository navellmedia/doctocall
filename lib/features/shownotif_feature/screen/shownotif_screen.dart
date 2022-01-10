import 'package:flutter/material.dart';

class ShownotifScreen extends StatefulWidget {
  const ShownotifScreen({Key? key}) : super(key: key);

  @override
  _ShownotifScreenState createState() => _ShownotifScreenState();
}

class _ShownotifScreenState extends State<ShownotifScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show notif Screen"),),
      body: Center(
        child:Text("Show notif Screen") ,
      ),
    );
  }
}
