import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TeamUP extends StatefulWidget {
  @override
  _TeamUPState createState() => _TeamUPState();
}

class _TeamUPState extends State<TeamUP> {
  final firestoreInstance = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  String UID = " ";

  String teamcode = " ";

  generate_team_token() async{
    var teamuid = Uuid();
    var result = teamuid.v1();
    int startIndex = 0;
    int endIndex = 7;
    teamcode = result.substring(startIndex, endIndex);
    print(teamcode);
    setState(() {});
    firestoreInstance.collection("Teams").doc(teamcode).set(
        {
        }
    ).then((_){
      print("success!");
    });

  }

  void getcurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          UID = user.uid;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  addteammate() async {
    firestoreInstance
        .collection("Teams")
        .doc(teamcode)
        .update({"UID": UID}).then((_) {
      print("success!");
    });
  }

  @override
  void initState() {
    getcurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            RaisedButton(
                child: Text('Create team'),
                onPressed: () {
                  generate_team_token();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            textColor: Theme.of(context).primaryColor,
                            child: Text('Close'),
                          ),
                        ],
                        title: Text('Your Teamcode'),
                        content: Column(
                          children: [
                            Text('Code: ${teamcode}'),
                          ],
                        ),
                      );
                    },
                  );
                }),
            RaisedButton(child: Text('Join team'), onPressed: () {
              addteammate();
            })
          ],
        ),
      ),
    );
  }
}
