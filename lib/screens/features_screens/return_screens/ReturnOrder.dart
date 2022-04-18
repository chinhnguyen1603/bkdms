import 'package:bkdms/screens/home_screens/order_status_screen/CreateSupplier.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/WaitConfirm.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/Delivering.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/Delivered.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/CancelOrder.dart';

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
        title: Text("Đơn hàng", style: TextStyle(fontSize: 20, color: Colors.black),),
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
              text: "Đang giao",   
            ),
            Tab(
              text: "Đã giao",  
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
          CreateSupplier(),
          WaitConfirm(),
          Delivering(),
          Delivered(),
          CancelOrder(),
        ],
      )
    );
  }
}