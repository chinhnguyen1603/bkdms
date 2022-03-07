import 'package:bkdms/HomePage/Login.dart';
import 'package:bkdms/HomePage/HomePage.dart';
import 'package:bkdms/HomePage/ResetPassword.dart';
import 'SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/HomePage/ResetPassword.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "BKDMS Mobile App",
      
      home: Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        //body: SplashScreen(),
       body: Login(),
     
      ),

    );
  }
}
