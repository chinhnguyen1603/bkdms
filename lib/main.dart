import 'package:bkdms/screens/home_screens/Login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Item.dart';
import 'splash_screen.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:bkdms/services/ProvinceProvider.dart';
import 'package:bkdms/models/TotalPayment.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bkdms/screens/home_screens/TestFirebase.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A cloud message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  State <MyApp> createState() =>  MyAppState();
}



class MyAppState extends State<MyApp> {
  bool changeToLogin = false;
  
  @override
  Widget build(BuildContext context) {
    //set 4s rồi chuyển qua Login
    Timer(Duration(seconds: 4), () {  
      setState(() {
        changeToLogin =true;
      });
    });  
   return MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => Agency()),
        ChangeNotifierProvider(create: (context) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => CountBadge()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProvinceProvider()),
        ChangeNotifierProvider(create: (context) => TotalPayment()),
    ],
    child: Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
           title: "BKDMS Mobile App",
           home: Scaffold(
             backgroundColor: Color(0xffF4F4F4),
             body: changeToLogin
                   ? Login()
                   : SplashScreen()
           ),
      );
      }
    )
  );
 }
}

