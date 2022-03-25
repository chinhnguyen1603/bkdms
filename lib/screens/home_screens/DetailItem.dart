import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarGrey.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Chi tiết sản phẩm"),
      body: SingleChildScrollView(
        child: Column(
           
        )
      ),
    );
  }
}