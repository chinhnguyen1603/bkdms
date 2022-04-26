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
  List <String> lstImage = ["assets/momo.png", "assets/totalMoney.png", "assets/banking.png"];
  List <String> lstType = ["momo", "banking", "momo", "money"];
  static const darkGrey = Color(0xff544c4c);

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
               itemCount: lstType.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  //xử lý hình ảnh tương ứng với phương thức thanh toán
                  String image = "";
                  if( lstType[index] == "momo") {
                    image = lstImage[0];
                  }
                  if( lstType[index] == "money") {
                    image = lstImage[1];
                  } 
                  if( lstType[index] == "banking") {
                    image = lstImage[2];
                  }                                     
                  //
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
                        alignment: Alignment.center,
                        //ảnh + text + số tiền tại đây
                        child: SizedBox(
                          width: myWidth,
                          height: 60,
                          child: Row(
                            children: [
                            //ảnh
                            SizedBox(
                              width: myWidth*0.2,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                  shape: BoxShape.circle,
                                ),   
                                child: SizedBox(height: 30,width: 30, child: Image.asset(image, fit: BoxFit.cover,), )
                              ),
                            ),                         
                            //text + time 
                            SizedBox(
                              height: 60,
                              width: myWidth*0.5,
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  SizedBox(
                                    width: myWidth*0.5,
                                    child: Text("Thanh toán ví Momo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    width: myWidth*0.5,
                                    child: Text("21/12/2022", style: TextStyle(color: darkGrey, fontSize: 13))
                                  )
                                ],
                              ),
                            ), 
                            //số tiền thanh toán
                            SizedBox(
                              height: 60,
                              width: myWidth*0.5,
                            )
                          ],
                        ),
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