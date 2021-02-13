import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id ='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = await _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return 'signInWithGoogle succeeded: $user';
  }
  @override
  void initState() {
   controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
   animation = ColorTween(begin: Colors.yellow,end: Colors.white).animate(controller);
   controller.forward();
   controller.addListener(() {
     setState(() {
       print(animation.value);
       print(controller.value);
     });
   });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value*100,
                  ),
                ),
        SizedBox(
          width: 210.0,
          child: ColorizeAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: [
              "Vamsi",
              "Kanit",
              "Gauri",
              "Geeth",
              "Tracker"
            ],
            textStyle: TextStyle(
                fontSize: 50.0,
                fontFamily: "Horizon",
              fontWeight: FontWeight.bold

            ),
            colors: [
             Colors.blue,
              Colors.deepOrange,
              Colors.orange,
              Colors.yellow,
              Colors.yellow,

            ],
            textAlign: TextAlign.start,
          ),
        )


              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.pushNamed(context, HomeScreen.id);

                    });
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Signin',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
