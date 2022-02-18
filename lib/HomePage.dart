import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0ECEC),
      body: ListView( 
          children: [
            // chứa gradient
            Container(
               height: 240,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50),),
                 gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomCenter,
                     colors: [Color(0xffFF5151),Color(0xff254FB0)],
                 ),
               ),
               // Column nội dung trong container
               child: Column(
                 children: [
                   SizedBox(height: 10,),
                   //text BKDMS đầu tiên
                   Text(
                     "BKDMS",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 40,
                       fontFamily: "SegoeScript",
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   //Row chứa Icon và dòng Xin chào khách hàng
                   Row(
                     children:[
                       SizedBox(width: 25,),
                       // Icon User
                       SizedBox(
                         width: 30,
                         height: 75,
                         child: IconButton(
                          onPressed: null, 
                          alignment: Alignment.topLeft,
                          icon: Icon(
                           Icons.account_circle_outlined,
                           size: 64,
                           color: Colors.white,
                          )
                         )
                       ),
                       SizedBox(width: 45,),
                       // 2 dòng text
                       SizedBox(
                         child: Column(
                            children:[
                              Text(
                               "Xin chào khách hàng \n",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w600,
                               color: Colors.white,
                               ),
                              )
                            ]
                         )
                       )
                     ],
                    ),
                   SizedBox(height: 25,),
                   Container(
                     width: 250,
                     height: 50,
                     decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       color: Colors.white,
                     ),
          
                   ),
                 ]
               )
            ),
          ],
        ),
        
      );
  }
}