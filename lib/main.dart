import 'package:flutter/material.dart';

import 'coreapp/routing/generate_routes.dart';
import 'coreapp/routing/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: Routes.ROOT,
      debugShowCheckedModeBanner: false,
    );
  }
}