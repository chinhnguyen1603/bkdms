import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({ Key? key }) : super(key: key);
  static const textColor = Color(0xff27214d);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      child: Column(
          children: [
            Container(width: 100.w, height: 10,),
            SizedBox(
              height: 20.h,
            ),
            Image.asset("assets/success.png"),
            SizedBox(height: 30,),
            SizedBox(
              width: 70.w,
              child: Text("Đặt hàng thành công!!!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: textColor),),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 70.w,
              child: Text("Thông tin đơn hàng đã được gửi và chờ xác nhận từ hệ thống", textAlign: TextAlign.center ,maxLines: 2, style: TextStyle(fontSize: 15, color: textColor),)
            ),
            SizedBox(height: 10.h,),
            //Button Đơn hàng
            SizedBox(
              height: 45,
              width: 30.w,
              child: ElevatedButton(
                onPressed: (){
         
                },
                style: ButtonStyle(
                   elevation: MaterialStateProperty.all(0),
                   backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690ff)),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     
                      RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                   )                                
                ), 
                child: Text("Đơn hàng", style: TextStyle(fontWeight: FontWeight.w700,),), 
              ),
            ),
            SizedBox(height: 30,),
            //Outline Button Về trang chủ
                        SizedBox(
                          height: 45,
                          width: 45.w,
                          child: OutlinedButton(
                             onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                             },
                             child: Text("Về trang chủ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                             style: OutlinedButton.styleFrom(
                                 side: BorderSide(color: Color(0xff4690ff)),
                             ),
                          )
                       ),

          ], 
          
      ),
      
    );
  }
}