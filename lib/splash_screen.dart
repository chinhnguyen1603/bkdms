import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen>{
  
   @override
  void initState() {
    super.initState();

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification as RemoteNotification;
      AndroidNotification android = message.notification?.android as AndroidNotification;
      if (notification != null && android != null)  {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ))
           .then((value)  async {
              await showDialog(
                 context: context,
                 builder: (_) {
                   return AlertDialog(
                      title: Text("Thông báo"),
                      content: Text("${notification.body}. Kiểm tra ngay tại mục đơn hàng.", style: TextStyle(color: Color(0xff544c4c)),),
              );
            });

            });
      }

    });
    
    //background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification as RemoteNotification;
      AndroidNotification android = message.notification?.android as AndroidNotification;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Thông báo"),
                content: Text("${notification.body}. Kiểm tra ngay tại mục đơn hàng.", style: TextStyle(color: Color(0xff544c4c)),),
              );
            });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: SingleChildScrollView( 
         child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image.asset("assets/DMSLogo.png"),//logo image
              
              // text giải pháp quản lý phân phối chuyên nghiệp
              Text(
                "GIẢI PHÁP QUẢN LÝ PHÂN PHỐI \n CHUYÊN NGHIỆP",
                style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Color(0xff565151),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60,),
             
              // vòng tròn loading
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  color: Colors.white,
                ),
                height: 180.0,
                width: 180.0,
              ),
              SizedBox(height: 120,),
   
              //text copyright
              SizedBox(
                child: Text(
                  "Copyright © BK.DMS",
                   style: TextStyle(
                     fontSize: 15,
                   ),
                ),
              )
            ],
          ),
        ),
      ),
      
    );
    
  }
}