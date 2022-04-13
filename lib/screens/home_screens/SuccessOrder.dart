import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/OrderProvider.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({ Key? key }) : super(key: key);
  static const textColor = Color(0xff27214d);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
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
              width: 80.w,
              child: Text("Đặt hàng thành công!!!", textAlign: TextAlign.center ,maxLines: 2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: textColor),),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 80.w,
              child: Text("Thông tin đơn hàng đã được gửi và chờ xác nhận từ hệ thống", textAlign: TextAlign.center ,maxLines: 2, style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w200),)
            ),
            SizedBox(height: 10.h,),
            //Button đến Đơn hàng
            SizedBox(
              height: 42,
              width: 30.w,
              child: ElevatedButton(
                onPressed: () async {
                   //update đơn hàng
                   Agency user = Provider.of<Agency>(context, listen: false);
                   await Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id);
                   //move to screen order
                   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(1)));
                },
                style: ButtonStyle(
                   elevation: MaterialStateProperty.all(0),
                   backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690ff)),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     
                      RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),)
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
                             onPressed: () async {
                                 //update đơn hàng
                                 Agency user = Provider.of<Agency>(context, listen: false);
                                 await Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id);
                                 //move to screen order                               
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0)));
                             },
                             child: Text("Về trang chủ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                             style: OutlinedButton.styleFrom(
                                 side: BorderSide(color: Color(0xff4690ff)),
                             ),
                          )
                       ),

          ], 
          
      ),
      )
    );
  }
}


