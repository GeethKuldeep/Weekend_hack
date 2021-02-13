
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack/screens/home_screen.dart';
import 'package:hack/screens/landing_screen.dart';
import 'package:hack/screens/welcome_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Crypto());
}

class Crypto extends StatelessWidget {
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
