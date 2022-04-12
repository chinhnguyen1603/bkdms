import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class WaitConfirm extends StatefulWidget {
  const WaitConfirm({ Key? key }) : super(key: key);

  @override
  State<WaitConfirm> createState() => WaitConfirmState();
}



class WaitConfirmState extends State<WaitConfirm> {
  List<OrderInfo> lstOrder = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }

  //widget 
  @override
  Widget build(BuildContext context) {
    //update lstOrder show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstOrder change
    List<OrderInfo> usedLstOrder = [];
    for( var order in lstOrder) {
        if(order.orderStatus == "WAITING_FOR_APPROVED" && order.type == "PURCHASE_ORDER"){
          usedLstOrder.add(order);
        }
    }
    //check if has or not order, mỗi lần update tự đặt isHasOrder = false, nếu có list thì về true
    bool isHasOrder = false;
    if(usedLstOrder.length !=0 ) {
      isHasOrder = true;
    }
    //
    return SingleChildScrollView(
      child: isHasOrder 
      //có đơn
      ? Container(
         child: Column( children: [
            SizedBox(width: 100.w, height: 10,),
            ListView.builder(
               itemCount:usedLstOrder.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                 return Column(
                   children: [   
                     //container chứa chi tiết đơn                 
                     Container(
                        width: 100.w,
                        height: 200,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text("Alo"),
                          ],
                        ),
                     ),
                     SizedBox(width: 100.w, height: 10,),   
                 ]);
               }
            )
         ])
        )       
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

  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(time));
    return timeConvert;
  }
}