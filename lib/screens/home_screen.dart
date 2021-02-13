import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hack/screens/friends_screen.dart';
import 'package:hack/screens/notifications_screen.dart';
import 'package:hack/screens/welcome_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:hack/widgets/Profile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  int currentPage = 0;
  String Email=" ";
  String Name =" ";
  String UID =" ";
  String DP = " ";

  @override
  void initState() {
    getcurrentUser();
    super.initState();
  }

  User loggedInUser;
  void getcurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          Name = user.displayName;
          print(Name);
          Email = user.email;
          UID = user.uid;
          DP = user.photoURL;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Notify();
      case 1:
        return Friends();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Profile(Name,DP,Email,UID),
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: 'logo',
                  child: Container(
                      height: 45.0,
                      child: Image.asset('images/logo.png')
                  )
              ),
              Text('VIT flex'),
            ],
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.notifications_active,
            title: "Notify",
          ),
          TabData(iconData: Icons.people_alt_outlined, title: "Friends")
        ],
        initialSelection: 0,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: _getPage(currentPage),
          ),
        ),
      ),
    );
  }
}
