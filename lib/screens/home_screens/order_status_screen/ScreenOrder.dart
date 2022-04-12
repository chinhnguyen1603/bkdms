import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/WaitConfirm.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/Delivering.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/Delivered.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/CancelOrder.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({ Key? key }) : super(key: key);

  @override
  State<ScreenOrder> createState() => ScreenOrderState();
}


class ScreenOrderState extends State<ScreenOrder> with TickerProviderStateMixin{
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
      backgroundColor: Color(0xffFAFAFA),
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
              text: "Hủy/Trả hàng",
            ),          
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WaitConfirm(),
          Delivering(),
          Delivered(),
          CancelOrder(),
        ],
      )
    );
  }
}