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

  Future<String?>getToken() async {
    final String? token= await firebaseMessaging.getToken();
    print(token);
    return token;
  }

  void onTokenRefresh(){
    firebaseMessaging.onTokenRefresh.listen((token) {
      print('Send to Api $token');
    });
  }

  Future<void> subscribeToTopics(String topicName) async {
    await firebaseMessaging.subscribeToTopic(topicName);
  }

  Future<void> unSubscribeToTopics(String topicName) async {
    await firebaseMessaging.unsubscribeFromTopic(topicName);
  }





}