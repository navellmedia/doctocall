import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  final dynamic doctorName;

  const DoctorScreen({Key? key, this.doctorName}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  String spesialis = "PARU";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isClose = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Yakin akan kembali"),
                content: Text("Simpan dahulu sebelum keluar halaman"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pop(true);
                        isClose = true;
                      },
                      child: Text("Yes"))
                ],
              );
            });
        return isClose;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Doctor ${widget.doctorName} Spesialis $spesialis"),
        ),
        body: Column(
          children: [
            Center(
              child: Text("Doctor ${widget.doctorName} Spesialis $spesialis"),
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
