import 'package:bkdms/HomePage/HomePage.dart';
import 'package:flutter/material.dart';

class TextGrey extends StatelessWidget {
  static const greyText = Color(0xff544c4c);
  String input;
  TextGrey(this.input);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$input",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: greyText,
      ),
    );
  }
}




class Contact extends StatelessWidget {
  static const greyBackground = Color(0xfffafafa);
  static const blueText = Color(0xff105480);


  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;
    
    return Scaffold(
      backgroundColor: greyBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greyBackground,       
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueText,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }, 
            icon: Icon(
              Icons.home_filled,
              color: blueText,
            )
          )
        ],      
        centerTitle: true,
        title: Text(
          "Liên hệ",
          style: TextStyle(
            fontSize: 20,
            color: blueText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          children: [
          SizedBox(height: 10,),
          SizedBox(
            width: myWidth,
            height: 20,
            child: TextGrey("Thông tin liên lạc"),       
          )

        ],
        ),
      ),
      )
    );
  }
}