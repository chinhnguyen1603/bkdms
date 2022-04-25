import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//lịch sử thanh toán bao gồm số tiền , thời gian, hình thức thanh toán

class PayHistory extends StatefulWidget {
  const PayHistory({ Key? key }) : super(key: key);

  @override
  State<PayHistory> createState() => PayHistoryState();
}

class PayHistoryState extends State<PayHistory> {
 
  @override
  Widget build(BuildContext context) {
    double myWidth = 90.w;
    //
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarTransparent(Colors.white, ""),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(width: 100.w, height: 1,),
             //container card payment
             Container(
               width: 60.w,
               height: 20.h,
               color: Color(0xfff6f7fa),
               alignment: Alignment.center,
               child: Image.asset("assets/cardPay.png"),
             ),
             SizedBox(height: 24,),
             
             //text lịch sử thanh toán
             SizedBox(
               width: myWidth,
               child: Text("Lịch sử thanh toán", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
             ),
             SizedBox(height: 12,),

             //ô lịch sử
             ListView.builder(
               itemCount: 4,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        width: myWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(37, 79, 176, 0.3),
                              blurRadius: 25,        
                              offset: Offset(0,2), 
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
             ),
             SizedBox(height: 20,)
          ]
        ),
      ),
    );
  }
}