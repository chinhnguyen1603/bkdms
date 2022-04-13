import 'package:bkdms/components/AppBarGrey.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:sizer/sizer.dart';


class DetailConfirm extends StatefulWidget {
  const DetailConfirm({ Key? key }) : super(key: key);

  @override
  State<DetailConfirm> createState() => DetailConfirmState();
}

class DetailConfirmState extends State<DetailConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Chi tiết đơn"),
      
    );
  }
}