import 'package:bkdms/screens/home_screens/SuccessOrder.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:bkdms/models/Agency.dart';

class InfoPayment extends StatelessWidget {
  const InfoPayment({ Key? key }) : super(key: key);
  static const darkGrey = Color(0xff544C4C);

  @override
  Widget build(BuildContext context) {
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    
    return Scaffold(
      appBar: AppBarGrey("Thanh toán"),
      body: SingleChildScrollView(
        child: Column(
          children: [
             // 3 icon đầu
            Container(
               width: 100.w,
               color: Colors.white,
               height: 70,
               child: Row(children: [
                 SizedBox(
                  width: 20.w,
                 ),
                 Container(
                   width: 13.w,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.blueAccent)
                   ),
                   child: Icon(
                     Icons.check,
                     size: 18,
                     color: Colors.blueAccent,
                   ),
                 ),
                 SizedBox(
                   width: 10.w,
                   child: Text("-----------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                 ),
                 Container(
                   width: 13.w,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.blueAccent)
                   ),
                   child: Icon(
                     Icons.check ,
                     size: 18,
                     color: Colors.blueAccent, 
                   ),
                 ),
                 SizedBox(
                   width: 10.w,
                   child: Text("--------------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                 ),
                 Container(
                   width: 13.w,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.grey)
                   ),
                   child: Icon(
                     Icons.credit_card,
                     size: 18,
                     color: darkGrey, 
                   ),                   
                 ),    
                 ]),
            ),
            SizedBox(height: 12,),
             
          ],
        ),

      ),
      //bottombar Tiếp tục
      bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(
                   color: Colors.grey,
                   blurRadius: 5.0,
                   spreadRadius: 0.0,
                   offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )],
              ),
              width: 100.w,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(
                          width: 90.w,
                          height: 24,
                          child: Row(children: [
                            //text thành tiền
                            SizedBox(
                              width: 30.w,
                              height: 24,
                              child: Center(
                                child: SizedBox(
                                  width: 30.w,
                                  child: Text("Thành tiền", style: TextStyle(color: darkGrey, fontSize: 14))
                                )
                              )
                            ),
                            //Tổng giá tiền
                            SizedBox(
                              width: 60.w,
                              height: 24,
                              child: Text(
                                "${Provider.of<OrderProvider>(context, listen: false).totalPayment.toString().replaceAllMapped(reg, mathFunc)}" + "đ", 
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                              )                              
                            )
                          ]),
                        ),
                        SizedBox(height: 7,),
                        SizedBox(
                          width: 90.w,
                          height: 40,
                          //button tiến hành đặt hàng
                          child: ElevatedButton(
                              onPressed: () async {  
                                  //cập nhật list product
                                  Provider.of<OrderProvider>(context, listen: false).setListProduct(Provider.of<CartProvider>(context, listen: false).lstCart);
                                  //đặt hàng
                                  Agency user = Provider.of<Agency>(context, listen: false);                
                                  await Provider.of<OrderProvider>(context, listen: false).createOrder(user.token, user.workspace, user.id);                      
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Đặt hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          
   );
  }
}