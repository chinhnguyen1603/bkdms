import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarGrey.dart';
class ScreenOrder extends StatelessWidget {
  const ScreenOrder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Đơn hàng"),
      body: Center(
        child: Text("OK"),
      ),
    );
  }
}