
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hack/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  Profile(this.Name,this.DP,this.Email,this.UID);
  String Email=" ";
  String Name =" ";
  String UID =" ";
  String DP = " ";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  File _imageFile  ;


  void signOutGoogle(context) async{
    await googleSignIn.signOut();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    print("User Sign Out");
  }
  void upload_screenshot() async{
    final picker = ImagePicker();
    final image = await picker.getImage( source: ImageSource.gallery);
    print('picked');
    setState(() {
        _imageFile = File(image.path);
        print(_imageFile);
    });


  }
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('${widget.UID}');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
    print('Uploaded');
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Profile'),
            ),
            if(widget.DP!= null)
              Image.network(widget.DP),
            if(widget.Name!=null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.Name),
              ),
            if(widget.Email!=null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.Email),
              ),
            if(widget.UID!=null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("User ID: ${widget.UID}"),
              ),
            if(_imageFile != null)
              Image.file(_imageFile),
            RaisedButton(child:Text('Gallery'),onPressed: (){
              upload_screenshot();
            }
            ),
            RaisedButton(child:Text('Upload'),onPressed: (){
              uploadImageToFirebase(context);
              ///uploadImageToFirebase(context);


            }),

            RaisedButton(
              color: Colors.red,
                onPressed:(){
                  signOutGoogle(context);

                },
                child: Text('Sign out'))
          ],
        ),
      ),
    );
  }
}




