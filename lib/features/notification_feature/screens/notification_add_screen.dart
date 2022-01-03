import 'package:doctorcall/coreapp/databases/db_provider.dart';
import 'package:doctorcall/coreapp/databases/notofication_model.dart';
import 'package:flutter/material.dart';

class NotificationAddScreen extends StatefulWidget {
  const NotificationAddScreen({Key? key, data}) : super(key: key);

  @override
  _NotificationAddScreenState createState() => _NotificationAddScreenState();
}

class _NotificationAddScreenState extends State<NotificationAddScreen> {
  String subject = "", body = "";
  int isread = 0, id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add data notif")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  id = int.tryParse(val) ?? 0;
                });
              },
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  subject = val;
                });
              },
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  body = val;
                });
              },
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  isread = int.tryParse(val) ?? 0;
                });
              },
            ),
            RaisedButton(
              onPressed: () async {
                NotificationModel notif = NotificationModel(
                    body: body, id: id, isread: isread, subject: subject);
                await DBProvider.db.insertData(notif);
                Navigator.pop(context);
              },
              child: Icon(Icons.save),
            )
          ],
        ),
      ),
    );
  }
}
