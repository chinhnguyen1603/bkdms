import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarGreyWithHome.dart';

class InfoApp extends StatelessWidget {
  static const darkGrey = Color(0xff544C4C);
  
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBarGreyWithHome("Thông tin ứng dụng"),
      backgroundColor: Color(0xffd9d9d9), // background color của màn hình
      body: SingleChildScrollView(
        child: Column(
          children: [
            //container chứa gradient
            Container(
               width: double.infinity,
               height: 140,
               child: Column(
                 children: [
                   SizedBox(height: 15,),
                   Text(
                     "BKDMS AGENCY",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 32,
                       fontFamily: "SegoeScript",
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                     ),
                   ), 
                   SizedBox(height: 5,), 
                   Text(
                     "Phiên bản 1.0.0",
                     style: TextStyle(
                       fontSize: 18,
                       color: Colors.white,
                     ),                     
                   ),
                   SizedBox(height: 5,),
                   Text(
                     "Kích thước 70MB",
                     style: TextStyle(
                       fontSize: 18,
                       color: Colors.white,
                     ),
                   )

                 ],
               ),
              ),
            SizedBox(height: 450,),
            
            // Text giấy chứng nhận đăng kí kinh doanh v.v
            SizedBox(
              width: myWidth,
              child: Text(
                "Giấy chứng nhận Đăng ký Kinh doanh số 0309456789 do Sở Kế hoạch và Đầu tư Thành phố Hồ Chí Minh cấp ngày 01/12/2021",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffc20000),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text("Copyright © BK.DMS", style: TextStyle(color: Color(0xffc20000)),),       
          ],
        ),
      ),
    );
  }
}