import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import '../Timezone.dart';
import '../main.dart';



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
        print(values);


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
        body:ListView.builder(
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
                              RaisedButton(
                                  child:Text('notify'),onPressed: (){
                                scheduleAlarm();
                              })
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

  void scheduleAlarm() async {
    final timeZone = TimeZone();
    String timeZoneName = await timeZone.getTimeZoneName();
    print(timeZoneName);
    print('0');
     tz.initializeTimeZones();
    print('0.1');
     await tz.setLocalLocation(await tz.getLocation(timeZoneName));
     print(tz.local);
    print(tz.local);
     var androidPlatformChannelSpecifics = AndroidNotificationDetails(

      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );
     print('2');
    var platformChannelSpecifics =NotificationDetails( android: androidPlatformChannelSpecifics);
     print('3');
    await flutterLocalNotificationsPlugin.zonedSchedule(0, keys[0], 'going start',tz.TZDateTime.from(values[0].toDate(), tz.local), platformChannelSpecifics, androidAllowWhileIdle: true,);
     print('4');
  }
}
