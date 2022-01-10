import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'coreapp/routing/generate_routes.dart';
import 'coreapp/routing/routes.dart';
import 'features/home_feature/bloc/home_bloc.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id,
    'High Importance Notification', //title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _messagingBgHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showLocalNotif(message);
}

Future<void> showLocalNotif(RemoteMessage message) async{
  RemoteNotification? notification = message.notification;
  flutterLocalNotificationsPlugin.show(notification.hashCode, notification?.title, notification?.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'
          )
      ));
}

Future<void> main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _token = await FirebaseMessaging.instance.getToken();
  print("Client Token = $_token");

  FirebaseMessaging.onBackgroundMessage(_messagingBgHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;

    if(notification!=null && androidNotification !=null){
      showLocalNotif(message);
    }
  });

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
