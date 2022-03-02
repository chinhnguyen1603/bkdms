import 'package:flutter/material.dart';

class AppBarGrey extends PreferredSize {
  static const darkGrey = Color(0xff544C4C); 
  final String textInCenter;
  AppBarGrey(this.textInCenter);
  
  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkGrey,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
            textInCenter,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: darkGrey,
            ),
        )
        );
  }
}