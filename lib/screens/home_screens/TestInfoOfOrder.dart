import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/models/InfoOfOrder.dart';

class TestInfoOfOrder extends StatelessWidget {
  const TestInfoOfOrder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Test info order"),
      body: Container(
        child: Column(children: [
          Text(""),
          Text(""),
        ]),
      ),
      
    );
  }
}