import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CancelOrder extends StatefulWidget {
  const CancelOrder({ Key? key }) : super(key: key);

  @override
  State<CancelOrder> createState() => CancelOrderState();
}


class CancelOrderState extends State<CancelOrder> {  
  List<String> lstCancelOrder= [];
  bool isHasOrder = false;
  
  //widget
  @override
  Widget build(BuildContext context) {
    //check if has or not order
    if(lstCancelOrder.length !=0 ) {
      isHasOrder = true;
    }
    return Container(
      child: isHasOrder 
      //có đơn
      ? Text("$lstCancelOrder")
      
      //không có đơn nào
      : Container(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 100,),
            Image.asset("assets/iconOrder.png", width: 100,),
            SizedBox(height: 10,),
            Text("Chưa có đơn hàng")
          ]
        )
      )
    );
  }
}