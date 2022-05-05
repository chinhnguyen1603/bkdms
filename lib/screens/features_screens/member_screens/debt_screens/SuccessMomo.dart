import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';
import 'package:bkdms/services/PaymentProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class SuccessMomo extends StatefulWidget {
  late Map payInfo;
  late int amount;
  SuccessMomo(this.payInfo, this.amount);

  @override
  State<SuccessMomo> createState() => _SuccessMomoState();
}

class _SuccessMomoState extends State<SuccessMomo> {
  double myHeight = 80.h;
  double myWidth = 90.w;
  static const textColor =Color(0xff17305f);

  //
  @override
  Widget build(BuildContext context) {
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xff164ec6),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(width:100.w, height: 10.h,),
                Container(
                  width: myWidth,
                  height: myHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      //logo success
                      SizedBox(width: myWidth, height: myHeight*0.05,),
                      Image.asset("assets/successMomo.png", height: myHeight*0.2,),
                      SizedBox(height: 10,),
                      
                      //text thành công + Cảm ơn bạn đã thanh toán công nợ
                      SizedBox(
                        width: myWidth,
                        child: Text("Thành công", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: textColor, fontWeight: FontWeight.w800),),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: myWidth,
                        child: Text("Cảm ơn bạn đã thanh toán công nợ.", textAlign: TextAlign.center, style: TextStyle( fontSize: 16 ,color: Color(0xff544c4c)),),
                      ),
                      SizedBox(height: 20,),

                      //container chứa tiền mới thanh toán
                      Container(
                        width: myWidth*0.8,
                        height: myHeight*0.15,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f3f5),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        alignment: Alignment.center,
                        child: Text("${widget.amount.toString().replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Color(0xff2e317f)),),
                      ),
                      SizedBox(height: 25,),

                      //thông tin thanh toán
                      SizedBox(
                        width: myWidth*0.8,
                        height: myHeight*0.2,
                        child: Column(
                          children: [
                            //hình thức thanh toán
                            Row(
                              children: [
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("Hình thức thanh toán: ", textAlign: TextAlign.left,),
                                ),
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("Ví điện tử Momo ", textAlign: TextAlign.right,),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            //Mã giao dịch
                            Row(
                              children: [
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("Mã giao dịch: ", textAlign: TextAlign.left,),
                                ),
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("${widget.payInfo['transid']}", textAlign: TextAlign.right,),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            //Thời gian
                            Row(
                              children: [
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("Thời gian: ", textAlign: TextAlign.left,),
                                ),
                                SizedBox(
                                  width: myWidth*0.4,
                                  child: Text("${convertTime(DateTime.now().toString())}", textAlign: TextAlign.right,),
                                )
                              ],
                            ),                            
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      
                      //button về trang chủ
                      SizedBox(
                        width: myWidth*0.8,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async{
                            //post giao dịch mới thanh toán
                            await showDialog (
                              context: context,
                              builder: (context) =>
                                FutureProgressDialog(postOnlinePay(widget.amount.toString())),
                            );
                            //move to Homepage
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(0)), (Route<dynamic> route) => false);
                          },
                          child: Text("Về trang chủ"),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder( borderRadius: BorderRadius.circular(20),)
                            )
                          ),
                        ),
                      )
                    ],              
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  // Hàm convert thời gian tạo id giao dịch
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }

  // hàm post giao dịch mới thanh toán xong
  Future postOnlinePay(String amount) {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);      
      Provider.of<PaymentProvider>(context, listen: false).postOnlinePay(user.token, user.workspace, user.id, amount)
      .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog delete cart");
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
            throw onError;          
      })
      .then((value) async {

      });    
    });
  }     

}