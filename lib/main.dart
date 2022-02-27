import 'package:flutter/material.dart';
import 'package:bkdms/splashScreen.dart';
import 'package:bkdms/InfoUser.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "BKDMS Mobile App",
      
      home: Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        //body: SplashScreen(),
        body: InfoUser(),
      ),

    );
  }
}





