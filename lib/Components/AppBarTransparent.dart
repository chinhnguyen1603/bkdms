import 'package:flutter/material.dart';

class AppBarTransparent extends StatelessWidget with PreferredSizeWidget {
   
  static const blueText = Color(0xff105480);
  final color;
  final String textInCenter;
  AppBarTransparent(this.color, this.textInCenter);
  
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