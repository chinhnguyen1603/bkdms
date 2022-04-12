import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/services/OrderProvider.dart';


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

  @override
  Widget build(BuildContext context) {
    //update lstOrder show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstOrder change
    List<OrderInfo> usedLstOrder = [];
    for( var order in lstOrder) {
        if(order.orderStatus == "WAITING_FOR_APPROVED" && order.type == "PURCHASE_ORDER"){
          usedLstOrder.add(order);
        }
    }
    //widget 
    return Container(
      child: ListView.builder(
         itemCount:usedLstOrder.length,              
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         itemBuilder: (BuildContext context, int index) {
            return Text("Đơn hàng #" + "${usedLstOrder[index].orderCode}");
         }
      )
    );
  }
}