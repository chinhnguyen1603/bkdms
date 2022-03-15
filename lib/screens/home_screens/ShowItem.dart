import 'package:bkdms/components/AppBarGeyWithHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowItem extends StatelessWidget {
  static const darkGrey = Color(0xff544C4C); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: darkGrey,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
            
            }, 
            icon: Icon(
              Icons.shopping_cart,
              color: darkGrey,
            )
          )
        ], 
        centerTitle: true,
        title: Text(
            "Sản phẩm",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: darkGrey,),
        )
      ),
      backgroundColor: Color(0xfff0ecec),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(),
            ListView(),
            //GridView(),
          ],
        )
      
      
      ,),
    );
  }
}