import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService{
  static final FirebaseMessaging _firebaseMessaging= FirebaseMessaging.instance;

  static Future<void> initialize()async{
    await _firebaseMessaging.requestPermission();
    // await _firebaseMessaging.requestPermission( // <--- hover to see options
    //   alert: true,
    //   announcement: true,
    //   sound: true,
    // );

    // Hide
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
    });

    //Foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
    });

    //FirebaseMessaging.onBackgroundMessage((message) => doSomething);
    FirebaseMessaging.onBackgroundMessage(doSomething);
    _listenToTokenRefresh();
  }
  static Future<String?> getFCMToken()async{
    return _firebaseMessaging.getToken();
  }
  static Future<void> _listenToTokenRefresh()async{ // token refreshes in every few days
    _firebaseMessaging.onTokenRefresh.listen((event) {
      //send token to the backend
    });
  }
}

Future <void> doSomething(RemoteMessage message)async{
  //some code
}