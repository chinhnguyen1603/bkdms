import 'package:bkdms/components/AppBarGrey.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:sizer/sizer.dart';


class DetailConfirm extends StatefulWidget {
  late OrderInfo orderInfo ;
  DetailConfirm(this.orderInfo);
  @override
  State<DetailConfirm> createState() => DetailConfirmState();
}

class DetailConfirmState extends State<DetailConfirm> {
  double myWidth = 95.w;

  @override
  Widget build(BuildContext context) {
    OrderInfo thisOrderInfo = widget.orderInfo;
    return Scaffold(
      appBar: AppBarGrey("Chi tiết đơn"),
      body: SingleChildScrollView(
          child: Column(
            children: [
              //order code + time
              Container(
                width: myWidth,
                height: 100,
                color: Colors.white,
                child: Column(
                  children: [
                     //icon và ordercode
                     Row(

                     )
                  ]
                ),
              )

          ]),
      ),
    );
  }
}