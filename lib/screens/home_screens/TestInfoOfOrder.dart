import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/OrderProvider.dart';
class TestInfoOfOrder extends StatelessWidget {
  const TestInfoOfOrder({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    OrderProvider myInfo = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBarGrey("Test info order"),
      body: Container(
        child: Column(children: [
          Text("${myInfo.note}"),
          Text("${myInfo.phone}"),
          Text("${myInfo.extra}"),
          Text("${myInfo.totalPayment}"),
          Text("${myInfo.ward}"),
        ]),
      ),
      
    );
  }
}