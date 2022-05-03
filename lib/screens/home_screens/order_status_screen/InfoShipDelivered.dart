import 'package:flutter/material.dart';

class InfoShipDelivered extends StatefulWidget {
  const InfoShipDelivered({ Key? key }) : super(key: key);

  @override
  State<InfoShipDelivered> createState() => _InfoShipDeliveredState();
}

class _InfoShipDeliveredState extends State<InfoShipDelivered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff7b2626),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Thông tin vận chuyển", style: TextStyle(color: Color(0xff7b2626)),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        
      ),
      
    );
  }
}