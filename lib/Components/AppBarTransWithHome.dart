import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';

class AppBarTransparentWithHome extends StatelessWidget with PreferredSizeWidget {
   
  static const blueText = Color(0xff105480);
  final color;
  final String textInCenter;
  AppBarTransparentWithHome(this.color, this.textInCenter);
  
  @override
  Size get preferredSize => Size.fromHeight(56);
 
  @override
  Widget build(BuildContext context) {
    return PreferredSize( preferredSize: Size.fromHeight(56), child: 
      AppBar(
        elevation: 0,
        backgroundColor: color,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueText,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0)));
            }, 
            icon: Icon(
              Icons.home_filled,
              color: blueText,
            )
          )
        ],
        centerTitle: true,
        title: Text(
            textInCenter,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: blueText,
            ),
        )
      ) 
    );
  }
}