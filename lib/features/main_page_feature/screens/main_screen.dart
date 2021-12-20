import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/home_feature/screens/home_screen.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:doctorcall/features/news_feature/screens/news_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserResponse? _userResponse;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var data = await SessionManagement.getUserData();
    _userResponse = data;
    print(_userResponse?.data?.name);
  }

  int _currentPageIndex =0;
  List<Widget> listPage = [
    HomeScreen(),
    NewsPage(),
    NewsPage(),
    NewsPage(),
  ];

  _onTap (int index){
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: "News Page"),
          BottomNavigationBarItem(icon: Icon(Icons.circle_notifications), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: "Profile")
        ],
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
      ),
    );
  }
}
