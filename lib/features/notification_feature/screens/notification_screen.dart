import 'dart:core';

import 'package:doctorcall/coreapp/databases/db_provider.dart';
import 'package:doctorcall/coreapp/databases/notofication_model.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifData = [];

  @override
  void initState() {
    super.initState();
  }

  getDataProvider() async {
    var data = await DBProvider.db.getDataAll();
    setState(() {
      notifData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: DBProvider.db.getDataAll(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext ctx, int idx) {
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(color: Colors.red,),
                      onDismissed: (direction){
                        DBProvider.db.deleteById(snapshot.data![idx].id??0);
                      },
                      child: ListTile(
                        title: Text(snapshot.data![idx].subject!),
                        subtitle: Text(snapshot.data![idx].body!),
                      ));
                });
          }
          return Center(child: Text("No-data"));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Routes.ADD_NOTIF_DATA);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
