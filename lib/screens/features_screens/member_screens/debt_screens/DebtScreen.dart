import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/features_screens/contact_screens/FeedBack.dart';
import 'package:bkdms/screens/features_screens/member_screens/debt_screens/DebtHistory.dart';
import 'package:bkdms/screens/features_screens/member_screens/debt_screens/PayHistory.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/screens/features_screens/member_screens/debt_screens/Momo.dart';
import 'package:bkdms/screens/features_screens/member_screens/debt_screens/PolicyDebt.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DebtScreen extends StatefulWidget {
  const DebtScreen({ Key? key }) : super(key: key);

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  double myWidth = 90.w;
  static const greyBorder = Color(0xffe5efeb);
  static const bigTextColor = Color(0xff1d3a70);
  static const smallTextColor = Color(0xff6b7280);  
  static const blueText = Color(0xff105480);
  static const textBottomSheet = Color(0xff7b2626);
  //biến Agency để lấy dư nọ hiện tại + tối đa + ngày cho phép nợ  
  late Agency user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<Agency>(context, listen: false);
  }
  
  @override
  Widget build(BuildContext context) {  
    double widthInContainer = myWidth*0.9;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //lấy tổng nợ cho phép + số ngày nợ + ngày bắt đầu
    String maxDebt ="", maxDebtPeriod ="", debtStartTime ="";
    if(user.maxDebt != null){
      maxDebt = user.maxDebt as String;
    } 
    if(user.maxDebtPeriod != null){
      maxDebtPeriod = user.maxDebtPeriod as String;
    }  
    if(user.debtStartTime != null){
      debtStartTime = user.debtStartTime as String;
    }          
    //
    return Scaffold(
      appBar: AppBarTransparent(Color(0xfffdfdfd), "Công nợ"),
      backgroundColor: Color(0xfffdfdfd),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 5,),
            //container card
            Container(
              width: myWidth,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(75, 106, 108, 114),
                    blurRadius: 3,        
                    offset: Offset(1,2), 
                  )
                ]
              ),
              child: Column(
                children: [
                  SizedBox(width: myWidth, height: 8,),
                  //tên cửa hàng + đang hoạt động
                  SizedBox(
                    width: widthInContainer,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(
                          width: widthInContainer*0.65,
                          child: Text("Cửa hàng Trung Việt", textAlign: TextAlign.left, style: TextStyle(color: Color(0xff7b2626), fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        //container đang hoạt động
                        Container(
                          height: 20,
                          width: widthInContainer*0.35,
                          decoration: BoxDecoration(            
                            color: Color(0xffdaf7bd),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: myWidth*0.9*0.35,
                              child: Text("Đang hoạt động", textAlign: TextAlign.center ,style: TextStyle(color: Color(0xff6ab73e), fontSize: 12,))
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  //text dư nợ cho phép + nợ tối đa
                  SizedBox(
                    width: widthInContainer,
                    child: Text("Dư nợ cho phép", style: TextStyle(color: Color(0xff544c4c)),),
                  ),
                  SizedBox(height: 3,),
                  SizedBox(
                    width: widthInContainer,
                    child: Text("${maxDebt.replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  ),
                  
                  //dư nợ hiện tại + hạn thanh toán
                  SizedBox(height: 20,),
                  SizedBox(
                    width: widthInContainer,
                    height: 50,
                    child: Row(children: [
                      //dư nợ hiện tại
                      Container(
                        color: Color(0xffff9f9f9),
                        height: 50,
                        width: widthInContainer*0.42,
                        child: Row(
                          children: [
                            SizedBox(width: 8,),
                            //
                            Column(
                              children: [
                                SizedBox(height: 8,),
                                SizedBox(width:widthInContainer*0.4-8, child: Text("Dư nợ hiện tại", textAlign: TextAlign.left ,style: TextStyle(color: Color(0xff544c4c)))),
                                SizedBox(width:widthInContainer*0.4-8 ,child: Text("${user.currentTotalDebt.replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      //Ngày thanh toán
                      Container(
                        color: Color(0xffff9f9f9),
                        height: 50,
                        width: widthInContainer*0.42,
                        child: Row(
                          children: [
                            SizedBox(width: 8,),
                            //
                            Column(
                              children: [
                                SizedBox(height: 8,),
                                SizedBox(width:widthInContainer*0.4-8, child: Text("Hạn thanh toán", textAlign: TextAlign.left ,style: TextStyle(color: Color(0xff544c4c)))),
                                SizedBox(width:widthInContainer*0.4-8 ,child: Text("05/06", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ],
                        ),
                      ),
 
                    ]),
                  )
               ],
              ),
            ),
            SizedBox(width: 100.w, height: 30,),
            
            //Hoạt động
            SizedBox(width: myWidth, child: Text("Hoạt động", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,),
            //3 icon button -> dùng gesturedetec
            SizedBox(
              width: myWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //lịch sử nợ
                  GestureDetector(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DebtHistory()));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.history, color: Color(0xff7b2626),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text("Lịch sử nợ"),
                      ],
                    ),
                  ),
                  //lịch sử thanh toán
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PayHistory()));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.credit_score, color: Color(0xffbfa652),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),                        
                        Text("Lịch sử thanh toán")
                      ],
                    ),
                  ),
                  //chính sách
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PolicyDebt()));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.post_add, color: Color(0xff105480),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),                          
                        Text("Chính sách")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 100.w, height: 25,),

            //Trả nợ
            SizedBox(width: myWidth, child: Text("Trả nợ", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,),
            //Container chứa các phương thức thanht toán
            SizedBox(
              width: myWidth,
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //tiền mặt
                  GestureDetector(
                    onTap: (){
                      if(int.parse(user.currentTotalDebt) <= 0){
                        //thông báo hiện tại không có nợ
                        Alert(
                           context: context,
                           type: AlertType.info,
                           desc: "Không có nợ hiện tại.",                
                           buttons: [ 
                             DialogButton(
                              child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.pop(context),
                              width: 100,
                             )
                           ],
                        ).show();
                      }
                      else{
                        //aleart dialog gửi yêu cầu
                        Alert(
                           context: context,
                           type: AlertType.none,
                           style: AlertStyle(
                             descTextAlign: TextAlign.start,
                             descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xff544c4c)),
                           ),
                           desc: "Gửi một yêu cầu thanh toán tiền mặt. Nhân viên của chúng tôi sẽ hỗ trợ sớm nhất có thể.",                
                           buttons: [ 
                             DialogButton(
                              child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBack())),
                              width: 100,
                             )
                           ],
                        ).show();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: myWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: greyBorder),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),                        
                      child: SizedBox(
                        width: myWidth,
                        height: 70,
                        child: Row(
                          children: [
                            //ảnh
                            SizedBox(
                              width: myWidth*0.3,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                  shape: BoxShape.circle,
                                ),   
                                child: SizedBox(height: 30,width: 30, child: Image.asset("assets/totalMoney.png", fit: BoxFit.cover,), )
                              ),
                            ),                         
                            //text 
                            SizedBox(
                              height: 70,
                              width: myWidth*0.6,
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("Tiền mặt", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("Phổ biến", style: TextStyle(color: smallTextColor, fontSize: 12))
                                  )
                                ],
                              ),
                            ) 
                          ],
                        ),
                      ),
                    ),
                  ),
                  //chuyển khoản
                  GestureDetector(
                    onTap: (){
                      if(int.parse(user.currentTotalDebt) <= 0){
                        //thông báo hiện tại không có nợ
                        Alert(
                           context: context,
                           type: AlertType.info,
                           desc: "Không có nợ hiện tại.",                
                           buttons: [ 
                             DialogButton(
                              child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.pop(context),
                              width: 100,
                             )
                           ],
                        ).show();
                      }
                      else{                      
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 60.h,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(width: 100.w , child: IconButton(
                                    icon: Icon(Icons.cancel_presentation, size: 18,),
                                    alignment: Alignment.centerRight,
                                    onPressed: (){Navigator.pop(context);},
                                  ),),
                                  SizedBox(width: 100.w, child:Text('Thanh toán chuyển khoản ngân hàng', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffde7325)),),),
                                  SizedBox(width: 100.w, height: 10,),
                                  //mô tả
                                  SizedBox(width: myWidth, child: Text("• Quý đại lý vui lòng chuyển tiền vào số tài khoản sau:"),),
                                  SizedBox(width: myWidth, child: Text("31410002851469 - Ngân hàng BIDV - chi nhánh Đông Sài Gòn.\nChủ tài khoản: Nguyen Ngoc Chinh", style: TextStyle(fontWeight: FontWeight.w600, color: textBottomSheet),),),
                                  SizedBox(width: 100.w, height: 5,),
                                  SizedBox(width: myWidth, child: Text("• Nội dung chuyển khoản ghi rõ như sau:"),),
                                  SizedBox(width: myWidth, child: Text("Tên đại lý - tên đại diện - thanh toán công nợ", style: TextStyle(fontWeight: FontWeight.w600, color: blueText,),),)
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 70,
                      width: myWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: greyBorder),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),                        
                      child: SizedBox(
                        width: myWidth,
                        height: 70,
                        child: Row(
                          children: [
                            //ảnh
                            SizedBox(
                              width: myWidth*0.3,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                  shape: BoxShape.circle,
                                ),   
                                child: SizedBox(height: 30,width: 30, child: Image.asset("assets/banking.png", fit: BoxFit.cover,), )
                              ),
                            ),                         
                            //text 
                            SizedBox(
                              height: 70,
                              width: myWidth*0.6,
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("Chuyển khoản", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("24/7", style: TextStyle(color: smallTextColor, fontSize: 12))
                                  )
                                ],
                              ),
                            ) 
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Ví momo
                  GestureDetector(
                    onTap: (){
                      if(int.parse(user.currentTotalDebt) <= 0){
                        //thông báo hiện tại không có nợ
                        Alert(
                           context: context,
                           type: AlertType.info,
                           desc: "Không có nợ hiện tại.",                
                           buttons: [ 
                             DialogButton(
                              child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.pop(context),
                              width: 100,
                             )
                           ],
                        ).show();
                      }
                      else{                        
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TestMomo()));
                      }
                    },
                    child: Container(
                      height: 70,
                      width: myWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: greyBorder),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),                        
                      child: SizedBox(
                        width: myWidth,
                        height: 70,
                        child: Row(
                          children: [
                            //ảnh
                            SizedBox(
                              width: myWidth*0.3,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                  shape: BoxShape.circle,
                                ),   
                                child: SizedBox(height: 30,width: 30, child: Image.asset("assets/momo.png", fit: BoxFit.cover,), )
                              ),
                            ),                         
                            //text 
                            SizedBox(
                              height: 70,
                              width: myWidth*0.6,
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("Ví điện tử Momo", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    width: myWidth*0.6,
                                    child: Text("Một chạm", style: TextStyle(color: smallTextColor, fontSize: 12))
                                  )
                                ],
                              ),
                            ) 
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ]
              ),
            )
          ]
        ),

      ),
    );
  }
}