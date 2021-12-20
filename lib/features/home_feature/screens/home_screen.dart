import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserResponse? _userResponse;

  @override
  void initState() {
    super.initState();
    getUserSession();
  }

  void getUserSession() async{
    var data =  await SessionManagement.getUserData();
    setState(() {
      _userResponse =data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            RichText(text: TextSpan(
              text: "HI ",
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: _userResponse==null?"":_userResponse?.data!.name!
                ),
                TextSpan(
                    text: ","
                )
              ]
            ))
          ],
        ),
      ),
    );
  }
}
