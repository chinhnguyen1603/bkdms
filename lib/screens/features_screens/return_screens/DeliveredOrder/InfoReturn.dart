import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/features_screens/return_screens/DeliveredOrder/MainPage.dart';
import 'package:bkdms/services/ReturnProvider.dart';

class InfoReturn extends StatefulWidget {
  
  //id + tổng tiền
  late String orderId;
  late int totalPayment;

  //địa chỉ nhận hàng
  late String extra;
  late String ward;
  late String district;
  late String province;  

  //biến lấy khi Detail Order truyền vào
  InfoReturn(this.orderId, this.totalPayment, this.extra, this.ward, this.district, this.province);
  @override
  State<InfoReturn> createState() => _InfoReturnState();
}

class _InfoReturnState extends State<InfoReturn> {
  static const heavyBlue = Color(0xff242266);
  static const darkGrey = Color(0xff544C4C);
  late String name;
  late String phone;

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
    //khởi tạo InfoOfOrder address &totalPayment
    Provider.of<ReturnProvider>(context, listen: false).setAddress(widget.province , widget.district, widget.ward , widget.extra);
    Provider.of<ReturnProvider>(context, listen: false).setTotalPayment(widget.totalPayment);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = 90.w;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: heavyBlue,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
            "Điền thông tin",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: heavyBlue,),
        )
      ),
     
      body: SingleChildScrollView(
        child: Column(
          children: [
             // 3 icon đầu
            Container(
               width: 100.w,
               color: Colors.white,
               height: 50,
               child: Column(children: [ 
                 SizedBox(height: 10,),
                // text Mặc định là thông tin khi đăng kí của đại lý
                 SizedBox(
                   height: 30,
                   child: Center(
                       child:  Text("Mặc định là thông tin khi nhận hàng của đại lý"),     
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
                // text địa chỉ 
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
                         child: Text("${widget.extra}," +" ${widget.ward}," +" ${widget.district},"+" ${widget.province}", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: darkGrey),),
                       ),
                     ],
                   )
                ),
                
              ],)
            ), 
            SizedBox(height: 12,),
            
            //FormField Lý do trả
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
                   child: Text("Lý do trả hàng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
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
     
      //bottombar Trả hàng
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
                                 Provider.of<ReturnProvider>(context, listen: false).setPhoneAndNote(phone, noteController.text);
                                 //post trả hàng tại đây
                                 Agency user = Provider.of<Agency>(context, listen: false);
                                 await Provider.of<ReturnProvider>(context, listen: false).createReturnOrder(user.token, user.workspace, user.id, widget.orderId)
                                    .catchError((onError) async {
                                      // phụ trợ xử lí String
                                      String fault = onError.toString().replaceAll("{message: ", ""); // remove {message:
                                      String outputError = fault.replaceAll("}", ""); //remove }  
                                      // Alert Dialog khi lỗi xảy ra
                                      print("Bắt lỗi tạo đơn trả");
                                      await showDialog(
                                        context: context, 
                                        builder: (ctx1) => AlertDialog(
                                          title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                                          content: Text("$outputError"),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(ctx1),
                                              child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                                            ),                      
                                          ],                                      
                                      ));    
                                      throw onError;          
                                    })
                                   .then((value) {
                                      //move to MainPagereturn(1) là trạng thái đơn trả
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPageReturn(1)), (Route<dynamic> route) => false);
                                   });   
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Trả hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          
      );  
  }

}