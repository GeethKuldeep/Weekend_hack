import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notify extends StatefulWidget {

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  List keys=[];
  List values=[];
  int length = 0;

   gettimetable()async{
    await FirebaseFirestore.instance.collection("WlEQLCt4aGc24Bs3aC2RqBssoc63").get().then((querySnapshot) {

      querySnapshot.docs.forEach((result) {
        setState(() {
          length = result.data().length;
          print(length);
        });
        keys.addAll(result.data().keys);
        values.addAll(result.data().values);


      });
    });

  }
  @override
  void initState() {
   gettimetable();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
            itemCount: length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(keys[index]),
                          Text('${values[index].toDate()}'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
