import 'package:bkdms/services/OrderProvider.dart';
import 'package:bkdms/services/PaymentProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/ProvinceProvider.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/TestProvince.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/InfoPayment.dart';


class InfoOrder extends StatefulWidget {
  late int totalPayment;
  InfoOrder(this.totalPayment);
  @override
  State<InfoOrder> createState() => _InfoOrderState();
}

class _InfoOrderState extends State<InfoOrder> {
  static const darkGrey = Color(0xff544C4C);
  late String name;
  late String phone;
  late String extra;
  late String ward;
  late String district;
  late String province;

  final noteController = TextEditingController();  

  // form thay đổi name
  final nameController = TextEditingController();  
  final _formNameKey = GlobalKey<FormState>();

  // form thay đổi phone
  final phoneController = TextEditingController();  
  final _formPhoneKey = GlobalKey<FormState>();
  
  
  @override
  void dispose(){
     noteController.dispose();
     phoneController.dispose();
     super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Agency user = Provider.of<Agency>(context, listen: false);
    name = user.nameOwn;
    phone = user.phone;
    //khởi tạo address trước
    extra = user.extraInfoOfAddress;
    ward = user.ward;
    district = user.district;
    province = user.province;
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //khởi tạo address UI bằng addressInfoOrder, update liên tục
    extra = Provider.of<OrderProvider>(context).extra;
    ward = Provider.of<OrderProvider>(context).ward;
    district = Provider.of<OrderProvider>(context).district;
    province = Provider.of<OrderProvider>(context).province;
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = 90.w;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';    

    //
    return Scaffold(
      appBar: AppBarGrey("Điền thông tin"),
      body: SingleChildScrollView(
        child: Column(
          children: [
             // 3 icon đầu
            Container(
               width: 100.w,
               color: Colors.white,
               height: 70,
               child: Column(children: [ 
                 SizedBox(height: 10,),
                 //Row chứa 3 icon đầu
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
                     border: Border.all(color: Colors.grey)
                   ),
                   child: Icon(
                     Icons.create_sharp ,
                     size: 18,
                     color: darkGrey, 
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
                 // text Mặc định là thông tin khi đăng kí của đại lý
                 SizedBox(
                   height: 30,
                   child: Center(
                       child:  Text("Mặc định là thông tin khi đăng kí của đại lý"),     
                   ),
                 )
               ],)
            ),
            SizedBox(height: 12,),
           
            //Container tên + số điện thoại + địa chỉ
            Container(
              width: 100.w,
              height: 240,
              color: Colors.white,
              child: Column(children: [
                SizedBox(height: 10,),
                // text họ và tên
                SizedBox(
                   width: myWidth,
                   height: 30,
                   child: Text("Họ và tên", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                // text tên đại lý + thay đổi
                SizedBox(
                   width: myWidth,
                   height: 24,
                   child: Row(
                     children: [
                       //tên 
                       SizedBox(
                         width: myWidth*0.7,
                         height: 24,
                         child: Text("$name", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: darkGrey),),
                       ),
                       //thay đổi
                       SizedBox(
                         width: myWidth*0.3,
                         height: 24,
                         child: GestureDetector(
                           onTap: (){
                              //Dialog điền tên mới
                              Alert(
                              context: context,
                              type: AlertType.none,
                              content: Form(
                               key: _formNameKey,
                               child: TextFormField(
                                 controller: nameController,
                                 keyboardType: TextInputType.text,
                                 cursorHeight: 20,
                                 cursorColor: Colors.black,
                                 textAlignVertical: TextAlignVertical.center,
                                 style: TextStyle(fontSize: 18),
                                 validator: (value) {
                                    if (value == null || value.isEmpty) {
                                       return "trống";
                                    }
                                    return null;
                                 },                
                                 decoration:  InputDecoration(
                                     prefixIcon: const Icon(Icons.abc,size: 26,),
                                 ),
                                ),
                              ),
                              buttons: [ 
                                 DialogButton(
                                    width: 100,
                                    child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                    onPressed: () {
                                       // check form có null không
                                       if (_formNameKey.currentState!.validate()){
                                         setState(() {
                                           name = nameController.text;
                                         });
                                         Navigator.pop(context);
                                       }
                                    },
                                    
                              )
                            ],
                           ).show();                             
                           },
                           child: Text("Thay đổi", textAlign: TextAlign.right ,style: TextStyle(color: Color(0xff105480), fontSize: 15,),),
                         ),
                       )
                     ],
                   )
                ),
                SizedBox(height: 15,),
                // text số điện thoại + thay đổi
                SizedBox(
                   width: myWidth,
                   height: 30,
                   child: Text("Số điện thoại", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),                
                SizedBox(
                   width: myWidth,
                   height: 24,
                   child: Row(
                     children: [
                       //Số điện thoại
                       SizedBox(
                         width: myWidth*0.7,
                         height: 24,
                         child: Text("$phone", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: darkGrey),),
                       ),
                       //text button thay đổi
                       SizedBox(
                         width: myWidth*0.3,
                         height: 24,
                         child: GestureDetector(
                           onTap: (){
                              //Dialog điền số điện thoại
                              Alert(
                              context: context,
                              type: AlertType.none,
                              content: Form(
                               key: _formPhoneKey,
                               child: TextFormField(
                                 controller: phoneController,
                                 keyboardType: TextInputType.number,
                                 cursorHeight: 20,
                                 cursorColor: Colors.black,
                                 textAlignVertical: TextAlignVertical.center,
                                 style: TextStyle(fontSize: 18),
                                 validator: (value) {
                                    if (value == null || value.isEmpty) {
                                       return "trống";
                                    }
                                    return null;
                                 },                
                                 decoration:  InputDecoration(
                                     prefixIcon: const Icon(Icons.phone_enabled,size: 26,),
                                 ),
                                ),
                              ),
                              buttons: [ 
                                 DialogButton(
                                    width: 100,
                                    child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                    onPressed: () {
                                       // check form có null không
                                       if (_formPhoneKey.currentState!.validate()){
                                         setState(() {
                                           phone = phoneController.text;
                                         });
                                         Navigator.pop(context);
                                       }

                                    },
                                    
                              )
                            ],
                           ).show();                             
                           },
                           child: Text("Thay đổi", textAlign: TextAlign.right ,style: TextStyle(color: Color(0xff105480), fontSize: 15,),),
                         ),
                       )
                     ],
                   )
                ),
                SizedBox(height: 15,),
                // text địa chỉ + thay đổi
                SizedBox(
                   width: myWidth,
                   height: 30,
                   child: Text("Địa chỉ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),                
                SizedBox(
                   width: myWidth,
                   height: 40,
                   child: Row(
                     children: [
                       //địa chỉ
                       SizedBox(
                         width: myWidth*0.8,
                         height: 40,
                         child: Text("$extra," +" $ward," +" $district,"+" $province", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: darkGrey),),
                       ),
                       //text button thay đổi
                       SizedBox(
                         width: myWidth*0.2,
                         height: 40,
                         child: GestureDetector(
                           onTap: () async {
                            await showDialog (
                               context: context,
                               builder: (context) => FutureProgressDialog(getAddress()),
                            );
                          },
                           child: Text("Thay đổi", textAlign: TextAlign.right ,style: TextStyle(color: Color(0xff105480), fontSize: 15,),),
                         ),
                       )
                     ],
                   )
                ),
                
              ],)
            ), 
            SizedBox(height: 12,),
            
            //FormField ghi chú
            Container(
              width: 100.w,
              height: 220,
              color: Colors.white,
              child: Column(children: [
                SizedBox(height: 10,),
                // text Ghi chú cho nhà cung cấp
                SizedBox(
                   width: myWidth,
                   height: 30,
                   child: Text("Ghi chú (nếu có)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                SizedBox(
                   width: myWidth,
                   height: 180,
                   child:  TextField(
                     controller: noteController,
                     maxLines: 5,
                     style: TextStyle(color: darkGrey),
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: "Viết tại đây",
                       labelText: "Note",
                     ),
                   ),
                )

              ],)
            )

          ],
        )
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
                                "${widget.totalPayment.toString().replaceAllMapped(reg, mathFunc)}" + "đ", 
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
                          //button tiến hành đặt hàng
                          child: ElevatedButton(
                              onPressed: () async {                          
                                 //set phone và note để tạo đơn hàng
                                 Provider.of<OrderProvider>(context, listen: false).setPhoneAndNote(phone, noteController.text);
                                 //show dialog chờ get order
                                 await showDialog (
                                  context: context,
                                  builder: (context) =>
                                    FutureProgressDialog(getOrderFuture()),
                                 );    
                                 //show dialog chờ get debt
                                 await showDialog (
                                  context: context,
                                  builder: (context) =>
                                    FutureProgressDialog(getDebtFuture()),
                                 );                                                               
                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  InfoPayment()));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiếp tục", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          

        

      );  
  }

  // hàm get order
  Future getOrderFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id)
        .catchError((onError) async {
          // phụ trợ xử lí String
          String fault = onError.toString().replaceAll("{", ""); // remove {
          String outputError = fault.replaceAll("}", ""); //remove }            
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog get order");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$outputError"),
                  actions: [TextButton(
                      onPressed: () => Navigator.pop(ctx1),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                  ),                      
                  ],                                      
              ));            
         })
        .then((value) async {
        });    
     });
  }      

  //hàm get debt
  Future getDebtFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<PaymentProvider>(context, listen: false).getDebt(user.token, user.workspace, user.id)
        .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog delete all cart");
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
        }).then((value) {
          //update agency tại đây
          Provider.of<Agency>(context, listen: false).updateValue(value);
        });   
    });
  }      


  // get api tỉnh thành giao hàng nhanh
  Future getAddress() {
    return Future(() async {
      await Provider.of<ProvinceProvider>(context, listen: false).getProvince()
      .catchError((onError){
         throw onError;
      })
      .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => TestProvince())), );
    });
  }
}