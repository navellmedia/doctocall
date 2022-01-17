import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/kategori_model.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  CollectionReference kategory =
      FirebaseFirestore.instance.collection('kategory');

  List<Kategory> listKategory = [];

  //CRUD (Create, Read, Update, Delete)
  Future<void> readDataKategory() async {
    QuerySnapshot result = await kategory //.where("kode", whereIn: ['SPT06'])
        .get();
    List<Kategory> data = result.docs.map((e) {
      var mapData = e.data() as Map<String, dynamic>;
      mapData.addAll({"id": e.id});

      return Kategory.fromJson(mapData);
    }).toList();

    setState(() {
      listKategory = data;
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

  Future<void> deleteData(String? id) async {
    print(id!);
    await kategory.doc(id).delete().then((value) {
      print("delete sukses");
      readDataKategory();
    }).catchError((error) => print("delete error $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fibase"),
          actions: [
            IconButton(
                onPressed: readDataKategory,
                icon: FaIcon(FontAwesomeIcons.search)),
            IconButton(onPressed: addData, icon: FaIcon(FontAwesomeIcons.save)),
          ],
        ),
        body: ListView.builder(
            itemCount: listKategory.length,
            itemBuilder: (BuildContext ctx, int idx) {
              Kategory item = listKategory[idx];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(item.kategori!),
                onLongPress: () async {
                  await deleteData(item.id!);
                },
              );
            }));
  }
}
