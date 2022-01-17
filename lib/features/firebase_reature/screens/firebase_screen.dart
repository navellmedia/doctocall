import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/kategori_model.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  CollectionReference kategory =
      FirebaseFirestore.instance.collection('kategory');

  //CRUD (Create, Read, Update, Delete)
  Future<void> readDataKategory() async {
    QuerySnapshot result = await kategory.get();
    List<Kategory> data = result.docs.map((e) {
      return Kategory.fromJson(e.data() as Map<String, dynamic>);
    }).toList();

    data.forEach((element) {
      print("${element.kode}-${element.kategori}");
    });
  }

  Future<void> addData() async {
    await kategory
        .add({
          "kategori": "Sepatu Kerja",
          "kode": "SPT06",
        })
        .then((value) => print("insert sukses"))
        .catchError((error) => print("insert error $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fibase"),
      ),
      body: ListView(
        children: [
          RaisedButton(
            onPressed: readDataKategory,
            child: Text("Get Data"),
          ),
          RaisedButton(
            onPressed: addData,
            child: Text("Add Data"),
          )
        ],
      ),
    );
  }
}
