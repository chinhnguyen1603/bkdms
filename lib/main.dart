import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
     @override 
     State<StatefulWidget> createState(){
       return MyAppState();
     }
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "BKDMS Mobile App",
      
      home: Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image.asset("assets/DMSLogo.png"),
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
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  color: Colors.white,
                ),
                height: 180.0,
                width: 180.0,
              ),
              SizedBox(height: 120,),
              SizedBox(
                child: Text(
                  "Copyright © BK.DMS",
                   style: TextStyle(
                     fontSize: 15,
                   ),
                ),
              ),
              
            ],
          ),
             
          

        ),
      ),
    );
  }
}
