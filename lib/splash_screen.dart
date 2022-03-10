import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/Login.dart';
import 'dart:async';



class SplashScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    });    return MaterialApp(      
      home: Scaffold(
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
      )
    );
    
  }
}