import 'package:bkdms/models/OrderInfo.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/SuccessOrder.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';


class InfoPayment extends StatefulWidget {
  const InfoPayment({ Key? key }) : super(key: key);

  @override
  State<InfoPayment> createState() => _InfoPaymentState();
}



class _InfoPaymentState extends State<InfoPayment> {
  
  static const darkGrey = Color(0xff544C4C);
  //biến Agency để lấy dư nọ hiện tại + dư nợ tối đa
  late Agency user;
  //khởi tạo radio = nợ đơn hàng
  int valueRadio = 1;
  String paymentType = "DEBT_PAYMENT";
  //lấy list order
  List<OrderInfo> lstOrder = [];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<Agency>(context);
    lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }
  //
  @override
  Widget build(BuildContext context) {
    String maxDebt ="0";
    if(user.maxDebt != null){
      maxDebt = user.maxDebt as String;
    }    
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    double myWidth = 90.w;
    //biến tổng tiền các đơn đang đặt
    int sumOfOrder = 0;
    //lấy tổng tiền từ các đơn đang xử lý
    for(var order in lstOrder){
      if(order.type == "PURCHASE_ORDER" && order.paymentType == 'DEBT_PAYMENT') {
        if (order.deliveredTime != null || order.cancelledTimeByAgency != null || order.cancelledTimeBySupplier != null){
          //loại những đơn này
        } 
        else{
          sumOfOrder = sumOfOrder + int.parse(order.totalPayment);
        }
      }
    }
    //
    return Scaffold(
      appBar: AppBarGrey("Thanh toán"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 3 icon đầu
            Container(
               width: 100.w,
               color: Colors.white,
               height: 70,
               child: Column(
                 children: [
                   SizedBox(height: 10,),
                   Row(children: [
                     SizedBox(
                      width: 20.w,
                     ),
                     Container(
                       width: 13.w,
                       height: 25,
                       decoration: new BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: Colors.blueAccent)
                       ),
                       child: Icon(
                         Icons.check,
                         size: 18,
                         color: Colors.blueAccent,
                       ),
                     ),
                     SizedBox(
                       width: 10.w,
                       child: Text("-----------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                     ),
                     Container(
                       width: 13.w,
                       height: 25,
                       decoration: new BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: Colors.blueAccent)
                       ),
                       child: Icon(
                         Icons.check ,
                         size: 18,
                         color: Colors.blueAccent, 
                       ),
                     ),
                     SizedBox(
                       width: 10.w,
                       child: Text("--------------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                     ),
                     Container(
                       width: 13.w,
                       height: 25,
                       decoration: new BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: Colors.grey)
                       ),
                       child: Icon(
                         Icons.credit_card,
                         size: 18,
                         color: darkGrey, 
                       ),                   
                     ),    
                     ]),
                 ],
               ),
            ),
            SizedBox(height: 12,),
            //Chính sách thanh toán
            Container(
              width: 100.w,
              height: 140,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  SizedBox(
                    width: myWidth,
                    height: 20,
                    child: Text("Chính sách thanh toán", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ), 
                  SizedBox(height: 8,),
                  //text giải thích
                  SizedBox(
                    width: myWidth,
                    child: Text(
                      "Có 2 hình thức là nợ đơn hàng(công nợ) và thanh toán COD(tiền mặt). \nNếu nợ đơn hàng, giá trị đơn hàng mới cộng với nợ hiện tại(bao gồm cả những đơn đang giao) không được vượt quá công nợ tối đa của bạn.",
                      maxLines: 5, 
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                  ),                   
                ],
              ),
            ),
            SizedBox(height: 12,),
            //Hạn mức
            Container(
              width: 100.w,
              height: 140,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  //text in đậm
                  SizedBox(
                    width: myWidth,
                    height: 20,
                    child: Text("Hạn mức", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                  ), 
                  SizedBox(height: 8,),
                  //số liệu
                  SizedBox(
                    width: myWidth,
                    height: 24,
                    child: Text("Mức nợ tối đa của bạn: ${maxDebt.replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                  ), 
                  SizedBox(
                    width: myWidth,
                    height: 24,
                    child: Text("Nợ hiện tại của bạn: ${user.currentTotalDebt.replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                  ),    
                  SizedBox(
                    width: myWidth,
                    height: 24,
                    child: Text("Tổng tiền đơn hàng đang giao: ${sumOfOrder.toString().replaceAllMapped(reg, mathFunc)}đ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                  ),                                  
                ],
              ),
            ),
            SizedBox(height: 12,),

            //Hình thức thanh toán
            Container(
              width: 100.w,
              height: 150,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  //text in đậm
                  SizedBox(
                    width: myWidth,
                    height: 20,
                    child: Text("Hình thức thanh toán", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                  ), 
                  SizedBox(height: 5,),
                  //radio Nợ đơn hàng + thanh toán COD
                  Column(
                    children: [
                      ListTile(
                        title: const Text("Nợ đơn hàng", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                        leading: Radio(
                          value: 1, 
                          groupValue: valueRadio, 
                          onChanged: (val) {
                            setState(() {
                              valueRadio = val as int ;
                            });
                          }
                        ),
                      ),
                      ListTile(
                        title: const Text("Thanh toán COD", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkGrey),),
                        leading: Radio(
                          value: 2, 
                          groupValue: valueRadio, 
                          onChanged: (val) {
                            setState(() {
                              valueRadio = val as int ;
                              this.paymentType = "COD_PAYMENT";
                            });
                          }
                        ),                        
                      )
                    ],
                  )                 
                ],
              ),
            ),
            SizedBox(height: 12,),

            //áp dụng khuyến mãi
            Container(
               width: 100.w,
               height: 80,
               color: Colors.white,
               child: SizedBox(
                  width: myWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      //text khuyến mãi
                      SizedBox(
                        width: myWidth,
                        height: 20,
                        child: Text("Khuyến mãi", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(height: 5,),
                      //formfield điền mã km
                      SizedBox(
                        width: myWidth,
                        height: 35,
                        child: Row(
                          children: [
                            SizedBox(
                              width: myWidth*0.65,
                              child:  TextFormField(
                                 keyboardType: TextInputType.text,
                                 cursorHeight: 24,
                                 textAlignVertical: TextAlignVertical.bottom,
                                 style: TextStyle(fontSize: 16, ),
                                 decoration:  InputDecoration(
                                    hintText: "Nhập mã",
                                    prefixIcon: Icon(Icons.discount_outlined),
                                    enabledBorder:  OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Color(0xff544c4c)),
                                    ),
                                 ), 
                              ), 
                            ),
                            SizedBox(width: myWidth*0.1,),
                            SizedBox(
                              width: myWidth*0.25,
                              child: ElevatedButton(
                              onPressed: (){}, 
                              child: Text("Áp dụng"),
                                 style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff105480)),
                                 ),                             
                            )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
               ),
             )
 
             
          ],
        ),

      ),
      //bottombar Tiếp tục
      bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(
                   color: Colors.grey,
                   blurRadius: 5.0,
                   spreadRadius: 0.0,
                   offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )],
              ),
              width: 100.w,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(
                          width: 90.w,
                          height: 24,
                          child: Row(children: [
                            //text thành tiền
                            SizedBox(
                              width: 30.w,
                              height: 24,
                              child: Center(
                                child: SizedBox(
                                  width: 30.w,
                                  child: Text("Thành tiền", style: TextStyle(color: darkGrey, fontSize: 14))
                                )
                              )
                            ),
                            //Tổng giá tiền
                            SizedBox(
                              width: 60.w,
                              height: 24,
                              child: Text(
                                "${Provider.of<OrderProvider>(context, listen: false).totalPayment.toString().replaceAllMapped(reg, mathFunc)}" + "đ",   
                                maxLines: 1,
                                textAlign: TextAlign.right, 
                                style: TextStyle(fontSize: 20, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                              )                              
                            )
                          ]),
                        ),
                        SizedBox(height: 7,),
                        SizedBox(
                          width: 90.w,
                          height: 40,
                          //button đặt hàng
                          child: ElevatedButton(
                              onPressed: () async {  
                                //hình thức thanh toán là nợ mới check
                                if(paymentType == "DEBT_PAYMENT"){
                                  //check xem tổng tiền + nợ hiện tại + đơn đang giao có lớn hơn nợ tối đa
                                  if( Provider.of<OrderProvider>(context, listen: false).totalPayment + int.parse(user.currentTotalDebt) + sumOfOrder > int.parse(maxDebt)){
                                    //show dialog lỗi
                                    Alert(
                                      context: context,
                                      type: AlertType.warning,
                                      style: AlertStyle( titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                                      title: "Vượt hạn mức nợ cho phép",
                                      buttons: [ DialogButton(
                                        child: Text("Quay lại", style: TextStyle(color: Colors.white, fontSize: 20),),
                                        onPressed: () => Navigator.pop(context),
                                        width: 100,
                                        )
                                      ],
                                    ).show();
                                  } else {
                                      //cập nhật list product
                                      Provider.of<OrderProvider>(context, listen: false).setListProduct(Provider.of<CartProvider>(context, listen: false).lstCart);
                                      //đặt hàng             
                                      await createOrderFuture();                 
                                  }
                                //hình thức thanh toán là COD thì post đơn hàng
                                } else{
                                    //cập nhật list product
                                    Provider.of<OrderProvider>(context, listen: false).setListProduct(Provider.of<CartProvider>(context, listen: false).lstCart);
                                    //đặt hàng             
                                    await createOrderFuture();   
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Đặt hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          
   );
  }

  // hàm create order
  Future createOrderFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<OrderProvider>(context, listen: false).createOrder(user.token, user.workspace, user.id, this.paymentType)
        .catchError((onError) async {
          // phụ trợ xử lí String
          String fault = onError.toString().replaceAll("{message: ", ""); // remove {message:
          String outputError = fault.replaceAll("}", ""); //remove }            
          // Alert Dialog khi lỗi xảy ra
          Alert(
            context: context,
            type: AlertType.error,
            style: AlertStyle(
              descTextAlign: TextAlign.start,
              descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xff544c4c)),
            ),
            desc: outputError,                
            buttons: [ 
              DialogButton(
                child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                onPressed: () => Navigator.pop(context),
                width: 100,
              )
            ],
          ).show();  
          throw onError;         
        }).then((_) {
          //push to success order
          Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessOrder())); 
        });     
      });
  }




}