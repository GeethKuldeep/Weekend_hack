
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hack/screens/home_screen.dart';
import 'package:hack/screens/landing_screen.dart';
import 'package:hack/screens/welcome_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async{
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification:(String payload )async{
        if(payload != null){
          debugPrint('notification payload' +payload);
        }
      } );

  await Firebase.initializeApp();
  runApp(hack());
}

class hack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LandingScreen.id ,
        routes:{
          LandingScreen.id:(context)=> LandingScreen(),
          WelcomeScreen.id:(context)=> WelcomeScreen(),
          HomeScreen.id:(context)=> HomeScreen(),
        }
    );
  }
}
