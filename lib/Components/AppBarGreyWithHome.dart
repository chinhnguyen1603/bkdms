import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';

class AppBarGreyWithHome extends StatelessWidget with PreferredSizeWidget {
  static const darkGrey = Color(0xff544C4C); 
  final String textInCenter;
  AppBarGreyWithHome(this.textInCenter,);
  
  @override
  Size get preferredSize => Size.fromHeight(56);
 
  @override
  Widget build(BuildContext context) {
    return PreferredSize( preferredSize: Size.fromHeight(56), child: 
      AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkGrey,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(0)), (Route<dynamic> route) => false);
            }, 
            icon: Icon(
              Icons.home_filled,
              color: darkGrey,
            )
          )
        ], 
        centerTitle: true,
        title: Text(
            textInCenter,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: darkGrey,
            ),
        )
      ) 
    );
  }
}