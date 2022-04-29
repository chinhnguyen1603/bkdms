import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class testTime extends StatelessWidget {
  
  String time = "2022-04-10T16:42:42.216Z";
  List<Map> lstStatus = []; 
  String testIMGNUll = "https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?k=20&m=1357365823&s=612x612&w=0&h=ZH0MQpeUoSHM3G2AWzc8KkGYRg4uP_kuu0Za8GFxdFc%3D&fbclid=IwAR1e6R4WMZ9PUH3se1u3k8gjwil5FJFWaeIzGl97oD-JXT4ZdRKJPww0pEQ";
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