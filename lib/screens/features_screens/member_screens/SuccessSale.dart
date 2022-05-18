import 'package:bkdms/services/ConsumerProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class SuccessSale extends StatefulWidget {
  const SuccessSale({ Key? key }) : super(key: key);

  @override
  State<SuccessSale> createState() => _SuccessSaleState();
}


class _SuccessSaleState extends State<SuccessSale> {
  static const textColor = Color(0xff27214d);

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
         color: Colors.white,
         child: Column(
            children: [
              Container(width: 100.w, height: 10,),
              SizedBox(
                height: 20.h,
              ),
              Image.asset("assets/success.png"),
              SizedBox(height: 30,),
              SizedBox(
                width: 80.w,
                child: Text("Tạo đơn thành công!!!", textAlign: TextAlign.center ,maxLines: 2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: textColor),),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 80.w,
                child: Text("Xem chi tiết đơn trong lịch sử bán hàng.", textAlign: TextAlign.center ,maxLines: 2, style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w400),)
              ),
              SizedBox(height: 20.h,),
              //Outline Button Về trang chủ
              SizedBox(
                height: 45,
                width: 45.w,
                child: OutlinedButton(
                  onPressed: () async {
                    //show dialog chờ cập nhật doanh số
                    await showDialog (
                      context: context,
                      builder: (context) =>
                        FutureProgressDialog(updateRevenueAgency()),
                    );  
                    //move to home page                               
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(0)), (Route<dynamic> route) => false);
                  },
                  child: Text("Về trang chủ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4690ff)),
                  ),
                )
              ),
            ],          
        ),
        )
      ),
    );
  }


  // hàm update doanh số
  Future updateRevenueAgency() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<ConsumerProvider>(context, listen: false).getRevenue(user.token, user.workspace, user.id)
        .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog create Sale");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$onError"),
                  actions: [TextButton(
                      onPressed: () => Navigator.pop(ctx1),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                  ),                      
                  ],                                      
              ));  
          //không được để throw onError ở đây mới chạy lệnh then được          
        }).then((value) {
          //update agency tại đây
          Provider.of<Agency>(context, listen: false).updateValue(value);
        });   
    });
  }      
}


