import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class Delivered extends StatefulWidget {
  const Delivered({ Key? key }) : super(key: key);

  @override
  State<Delivered> createState() => DeliveredState();
}


class DeliveredState extends State<Delivered> {  
  List<String> lstDelivered = [];
  
  //widget
  @override
  Widget build(BuildContext context) {
    //check if has or not order, phải để trong widget để build lại khi list change
    bool isHasOrder = false;
    if(lstDelivered.length !=0 ) {
      isHasOrder = true;
    }
    //
    return Container(
      child: isHasOrder 
      //có đơn
      ? Text("$lstDelivered")
      
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