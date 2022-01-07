import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:doctorcall/features/profile_feature/screens/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakepictureScreen extends StatefulWidget {
  final CameraDescription? cameraDescription;
  const TakepictureScreen({Key? key,this.cameraDescription}) : super(key: key);

  @override
  _TakepictureScreenState createState() => _TakepictureScreenState();
}

class _TakepictureScreenState extends State<TakepictureScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  int _isRearCameraSelected=0;

  @override
  void initState(){
    super.initState();
    getCamera();
  }

  Future<void> getCamera() async{
    final cameras = await availableCameras();
    setState(() {
      _controller = CameraController(
        cameras[_isRearCameraSelected],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller!.initialize();
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Take Picture"),),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller!);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async{
                switchCamera();
              },
              child: Icon(Icons.camera),
            ),
            FloatingActionButton(
              onPressed: ()async{
                takeCamera();
              },
              child: Icon(Icons.camera_alt),
            ),
          ],
        ),
      ),
    );
  }

  void takeCamera() async{
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      Navigator.pop(context, image.path);
      //
      // await Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => DisplayScreen(
      //       imagePath: image.path,
      //     ),
      //   ),
      // );
    } catch (e) {
      print(e);
    }
  }

  void switchCamera() async{
    setState(() {
      _isRearCameraSelected = _isRearCameraSelected==0?1:0;
    });
    final cameras = await availableCameras();
    setState(() {
      _controller = CameraController(
        cameras[_isRearCameraSelected],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller!.initialize();
    });
  }
}
