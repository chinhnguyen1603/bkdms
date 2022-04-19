import 'package:bkdms/screens/features_screens/return_screens/CancelReturn.dart';
import 'package:bkdms/screens/features_screens/return_screens/OrderConfirm.dart';
import 'package:bkdms/screens/features_screens/return_screens/OrderReturned.dart';
import 'package:bkdms/screens/features_screens/return_screens/OrderReturning.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/CreateSupplier.dart';
import 'package:flutter/material.dart';

class ReturnOrder extends StatefulWidget {
  const ReturnOrder({ Key? key }) : super(key: key);

  @override
  State< ReturnOrder> createState() =>  ReturnOrderState();
}


class  ReturnOrderState extends State< ReturnOrder> with TickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
     //tab page view
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0ecec),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Đơn trả", style: TextStyle(fontSize: 20, color: Colors.black),),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: Color(0xff7b2626),
          indicatorColor: Color(0xff7b2626),
          unselectedLabelColor: Color(0xff544c4c),
          tabs: const <Widget>[           
            Tab(
              text: "Chờ xác nhận",     
            ),
            Tab(
              text: "Đang trả hàng",   
            ),
            Tab(
              text: "Đã trả hàng",  
            ),
            Tab(
              text: "Đã hủy",
            ),          
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderConfirm(),
          OrderReturning(),
          OrderReturned(),
          CancelReturn(),
        ],
      )
    );
  }
}