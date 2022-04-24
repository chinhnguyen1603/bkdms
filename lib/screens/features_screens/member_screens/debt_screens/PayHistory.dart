import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//lịch sử thanh toán bao gồm số tiền , thời gian, hình thức thanh toán

class PayHistory extends StatefulWidget {
  const PayHistory({ Key? key }) : super(key: key);

  @override
  State<PayHistory> createState() => PayHistoryState();
}

class PayHistoryState extends State<PayHistory> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f5f6),
      appBar: PreferredSize(       
        preferredSize: Size.fromHeight(70), 
        child: AppBar(
           elevation: 0,
           backgroundColor: Color(0xffe01e5a),
           leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
           ),
           centerTitle: true,
           title: Text(
              "Lịch sử thanh toán",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),
           )
        ) 
      ),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 50,),
             ListView.builder(
               itemCount: 10,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        width: 90.w,
                        height: 80,
                        color: Colors.white,
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
             ),
             SizedBox(height: 50,)
          ]
        ),
      ),
    );
  }
}