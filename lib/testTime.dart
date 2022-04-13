import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class testTime extends StatelessWidget {
  
  String time = "2022-04-10T16:42:42.216Z";
  List<Map> lstStatus = []; 
  @override
  Widget build(BuildContext context) {
    var test = DateFormat('hh:mm:ss dd/MM/yyyy').format(DateTime.parse(time));
    lstStatus.add({
      "status": "  Đang giao hàng",
      "time": "16:03 22-03-2022"
    });
    lstStatus.add({
      "status": "Đã nhận hàng",
      "time": "17:00 22-04-2022"
    });
    return Container(
      child: ListView.builder(
        itemCount: lstStatus.length,
        itemBuilder: (BuildContext context, int index) {
           return Column(
             children: [
               Text("${lstStatus[index]['status']}" + "  ${lstStatus[index]['time']}" )
             ],

           );
        }
      
      )
    );
  }
}