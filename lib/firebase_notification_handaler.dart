import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandler{

  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;

  Future<void> initialization() async {
    await firebaseMessaging.requestPermission(
        sound: true,
        badge:true,
        alert: true,
        criticalAlert: true
    );


    //Listen Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      print(message.notification?.body?? 'Empty body');
      print(message.notification?.title?? 'Empty body');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("This is from Open appp");
      print(message.notification?.body?? 'Empty body');
      print(message.notification?.title?? 'Empty body');

    });


  }



}