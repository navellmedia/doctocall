import 'package:camera/camera.dart';
import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:doctorcall/features/profile_feature/screens/takepicture_screens.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  UserResponse? _userResponse;

  @override
  void initState() {
    super.initState();
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
                  onTap: (){
                    //if(cameraDescription!=null){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakepictureScreen(),
                        ),
                      );
                    //}
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://www.achievers.com/blog/wp-content/uploads/2020/05/05-27-20.jpg"),
                  ),
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
}
