import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/models/PayHistoryInfo.dart';
import 'package:bkdms/services/PaymentProvider.dart';
//lịch sử thanh toán bao gồm số tiền , thời gian, hình thức thanh toán

class PayHistory extends StatefulWidget {
  const PayHistory({ Key? key }) : super(key: key);

  @override
  State<PayHistory> createState() => _PayHistoryState();
}

class _PayHistoryState extends State<PayHistory> {
  List <String> lstImage = ["assets/momo.png", "assets/totalMoney.png", "assets/banking.png"];
  static const darkGrey = Color(0xff544c4c);
  List<PayHistoryInfo> lstPayHistory = [];

  @override
  void initState() {
    super.initState();
    lstPayHistory = Provider.of<PaymentProvider>(context, listen: false).lstPayHistory;
    print(lstPayHistory.length);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = 90.w;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarTransparent(Colors.white, ""),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(width: 100.w, height: 1,),
             //container card payment
             Container(
               width: 60.w,
               height: 20.h,
               color: Color(0xfff6f7fa),
               alignment: Alignment.center,
               child: Image.asset("assets/cardPay.png"),
             ),
             SizedBox(height: 24,),
             
             //text lịch sử thanh toán
             SizedBox(
               width: myWidth,
               child: Text("Lịch sử thanh toán", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
             ),
             SizedBox(height: 12,),

             //ô lịch sử
             ListView.builder(
               reverse: true,
               itemCount: lstPayHistory.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  //xử lý hình ảnh + text tương ứng với phương thức thanh toán
                  String image = "", type ="";
                  if( lstPayHistory[index].type == "ONLINE_PAYMENT") {
                    image = lstImage[0];
                    type = "Thanh toán ví Momo";
                  } else {
                    image = lstImage[1];
                    type = "Thanh toán tiền mặt";
                  }                                   
                  //
                  return Column(
                    children: [
                      Container(
                        width: myWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(37, 79, 176, 0.3),
                              blurRadius: 25,        
                              offset: Offset(0,2), 
                            )
                          ]
                        ),
                        alignment: Alignment.center,
                        //ảnh + text + số tiền tại đây
                        child: SizedBox(
                          width: myWidth,
                          height: 60,
                          child: Row(
                            children: [
                            //ảnh
                            SizedBox(
                              width: myWidth*0.2,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                  shape: BoxShape.circle,
                                ),   
                                child: SizedBox(height: 30,width: 30, child: Image.asset(image, fit: BoxFit.cover,), )
                              ),
                            ),                         
                            //text + time 
                            SizedBox(
                              height: 60,
                              width: myWidth*0.45,
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  SizedBox(
                                    width: myWidth*0.45,
                                    child: Text("$type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    width: myWidth*0.45,
                                    child: Text("${convertTime(lstPayHistory[index].time)}", style: TextStyle(color: darkGrey, fontSize: 13))
                                  )
                                ],
                              ),
                            ), 
                            //số tiền thanh toán
                            Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: myWidth*0.35,
                              child: Text(
                                "-" + "${lstPayHistory[index].amount.replaceAllMapped(reg, mathFunc)}đ",
                                style: TextStyle(
                                  color: Color(0xff7b2626),
                                  fontSize: 14, 
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
 
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
             ),
             SizedBox(height: 20,)
          ]
        ),
      ),
    );
  }

  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }

}