import 'package:hack/screens/home_screen.dart';
import 'package:hack/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack/screens/welcome_screen.dart';

import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  static const String id ='landing_screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final auth =FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user != null) {
              return HomeScreen();
            }
            return WelcomeScreen();
          }
          else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}
