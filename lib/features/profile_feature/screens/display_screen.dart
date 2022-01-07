import 'dart:io';

import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  final String imagePath;
  const DisplayScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Center(
        child: Image.file(File(widget.imagePath)),
      ),
    );
  }
}
