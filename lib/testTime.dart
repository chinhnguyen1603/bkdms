import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class testTime extends StatelessWidget {
  
  String time = "2022-04-10T16:42:42.216Z";
  
  @override
  Widget build(BuildContext context) {
    var test = DateFormat('hh:mm:ss dd/MM/yyyy').format(DateTime.parse(time));
    return Container(
      child: Text("$test"),
    );
  }
}