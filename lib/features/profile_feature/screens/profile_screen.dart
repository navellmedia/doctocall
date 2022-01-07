import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:doctorcall/features/profile_feature/screens/takepicture_screens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserResponse? _userResponse;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _imgFromCamera() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      final File? file = File(image.path);

      setState(() {
        _image = file;
      });
    }
  }

  Future<void> _imgFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      final File? file = File(image.path);

      setState(() {
        _image = file;
      });
    }
  }

  _imageCustomCamera() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakepictureScreen(),
      ),
    );

    if (result != null) {
      SessionManagement.setImageProfile(result);
      setState(() {
        _image = File(result);
      });
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    initFile();
    super.initState();
  }

  initFile() async{
    var _path = await SessionManagement.getImageProfile();
    if(_path.length> 0){
      setState(() {
        _image = File(_path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _showPicker(context);
                    //_imageCustomCamera();
                  },
                  child: _image == null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              "https://www.achievers.com/blog/wp-content/uploads/2020/05/05-27-20.jpg"))
                      : CircleAvatar(
                          radius: 40, backgroundImage: FileImage(_image!)),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "",
                            style: Theme.of(context).textTheme.headline6,
                            children: [
                          TextSpan(
                              text: _userResponse == null
                                  ? ""
                                  : _userResponse?.data!.name!),
                        ])),
                    SizedBox(
                      height: 2,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "",
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                          TextSpan(
                              text: _userResponse == null
                                  ? ""
                                  : _userResponse?.data!.email!),
                        ])),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Divider(),
            ListTile(
              title: Text("Nama"),
              subtitle: Text(_userResponse?.data!.name ?? ""),
            ),
            ListTile(
              title: Text("Email"),
              subtitle: Text(_userResponse?.data!.email ?? ""),
            ),
            RaisedButton(
              color: Colors.orangeAccent,
              onPressed: () {
                SessionManagement.setLogout();
                Navigator.pushReplacementNamed(context, Routes.LOGIN);
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Custom Camera'),
                    onTap: () {
                      _imageCustomCamera();
                      //Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
