import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coreapp/routing/generate_routes.dart';
import 'coreapp/routing/routes.dart';
import 'features/home_feature/bloc/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc())
        ],
        child: MaterialApp(
          title: 'Doctor Call',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: generateRoute,
          initialRoute: Routes.ROOT,
          debugShowCheckedModeBanner: false,
        ));
  }
}
