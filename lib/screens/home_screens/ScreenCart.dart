import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarGrey.dart';

class ScreenCart extends StatelessWidget {
  static const darkGrey = Color(0xff544C4C);
  
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBarGrey("Giỏ hàng"),
      backgroundColor: Color(0xffF0ECEC), // background color của màn hình
      body: SingleChildScrollView(
        child: Column(
          children: [
            //container chứa gradient
            Container(
               width: double.infinity,
               height: 140,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomCenter,
                     colors: [Color(0xffFF3A5E),Color(0xffFFE4AF)],
                 ),
               ),
            )  
          ],
        ),
      ),
    );
  }
}