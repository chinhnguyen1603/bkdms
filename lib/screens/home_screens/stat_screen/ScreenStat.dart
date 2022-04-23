import 'package:bkdms/screens/home_screens/stat_screen/PurchaseMoney.dart';
import 'package:bkdms/screens/home_screens/stat_screen/TurnoverMoney.dart';
import 'package:flutter/material.dart';

class ScreenStat extends StatefulWidget {
  const ScreenStat({ Key? key }) : super(key: key);

  @override
  State<ScreenStat> createState() => ScreenStatState();
}


class ScreenStatState extends State<ScreenStat> with TickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
     //tab page view
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0ecec),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Biểu đồ doanh số", style: TextStyle(fontSize: 20, color: Colors.black),),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: false,
          controller: _tabController,
          labelColor: Color(0xff105480),
          indicatorColor: Color(0xff105480),
          unselectedLabelColor: Color(0xff544c4c),
          tabs: const <Widget>[
            Tab(
              text: "Nhập vào",     
            ),            
            Tab(
              text: "Bán ra",     
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PurchaseMoney(),
          TurnoverMoney(),
        ],
      )

    );
  }

}