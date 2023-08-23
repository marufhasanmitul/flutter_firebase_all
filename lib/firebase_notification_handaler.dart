import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandler{

  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;

  Future<void> initialization() async {
    await firebaseMessaging.requestPermission(
        sound: true,
        announcement: false,
        carPlay: false,
        badge:true,
        alert: true,
        criticalAlert: false,
        provisional: false
    );


    //Listen Notification
    FirebaseMessaging.onMessage.listen((messageHandler));

    FirebaseMessaging.onMessageOpenedApp.listen(messageHandler);
    
    FirebaseMessaging.onBackgroundMessage(firebaseMessingBackgroundHandler);

    RemoteMessage? message =await FirebaseMessaging.instance.getInitialMessage();
    if(message!=null){
      messageHandler(message);
    }


  }

  Future<void> messageHandler(RemoteMessage message)async{
    print(message.data);
    print(message.notification?.body?? 'Empty body');
    print(message.notification?.title?? 'Empty body');
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
//app kill But Notification get
Future<void> firebaseMessingBackgroundHandler(RemoteMessage message)async{
  print(message.data);
  print(message.notification?.body?? 'Empty body');
  print(message.notification?.title?? 'Empty body');
}


