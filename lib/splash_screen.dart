import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bkdms/screens/home_screens/homepage_screens/Login.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen>{
   

  @override
  Widget build(BuildContext context) {
    String fcmToken ="";
      //set 4s rồi chuyển qua Login
    Timer(Duration(seconds: 4), () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    }); 
    //
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