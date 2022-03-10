import 'package:bkdms/screens/home_screens/Login.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/screens/Features_screens/Member.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "BKDMS Mobile App",
      
      home: Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: HomePage(),
       
      ),

    );
  }
}
