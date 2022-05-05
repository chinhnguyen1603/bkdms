import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/screens/features_screens/return_screens/DeliveredOrder/InfoReturn.dart';
import 'package:bkdms/services/AmountReturnProvider.dart';
import 'package:bkdms/services/ReturnProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/OrderInfo.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DetailOrder extends StatefulWidget {
  late OrderInfo orderDeliveredInfo ;
  DetailOrder(this.orderDeliveredInfo);
  
  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  double heightDevice =100.h;
  double myWidth = 90.w;
  static const darkBlue = Color(0xff27214d);
  static const darkGrey = Color(0xff544c4c);

  //form nhập số lượng sản phẩm
  final _formEnterAmountKey = GlobalKey<FormState>();
  final enternAmountController = TextEditingController();

  //tổng tiền hoàn
  int sumOfOrder = 0;
  //list số lượng mặt hàng gốc trong cart
  List<String> lstAmount = [];
  //list số lượng provider
  List<String> lstAmountProvider = [];

  @override
  void initState() {
    super.initState();
    //khởi tạo bằng total payment của đơn
    sumOfOrder = int.parse(widget.orderDeliveredInfo.totalPayment);
    //khởi tạo list số lượng ban đầu(gốc)
    for (var order in widget.orderDeliveredInfo.orderDetails){
      lstAmount.add(order['quantity']);
    }
    //khởi tạo list provider
    int i=0;
    for (var order in widget.orderDeliveredInfo.orderDetails){
      Provider.of<AmountReturnProvider>(context, listen: false).initList(i, order['quantity']);
      i++;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lstAmountProvider = Provider.of<AmountReturnProvider>(context).lstAmount;
    // cập nhật tổng tiền của giỏ hàng
    sumOfOrder = 0;
    for (var index = 0; index < lstAmountProvider.length; index++) {
      sumOfOrder = sumOfOrder + int.parse(widget.orderDeliveredInfo.orderDetails[index]['price'])*int.parse(lstAmountProvider[index]);
    }
  }
  


  @override
  Widget build(BuildContext context) {
    OrderInfo thisOrderDelivered = widget.orderDeliveredInfo;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //lấy hình thức thanh toán của đơn
    String paymentType = "Thanh toán nợ";
    if(thisOrderDelivered.paymentType == "COD_PAYMENT") {
      paymentType = "Thanh toán COD";
    }  
    //list order detail của đơn
    List<dynamic> lstOrderDetail = widget.orderDeliveredInfo.orderDetails;     
    //widget
    return Scaffold(
      appBar: AppBarGrey("Chi tiết đơn"),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(color: Colors.white, width: 100.w,height: 15,),
              //order code + time
              Container(
                width: 100.w,
                height: 100,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  height: 100,
                  child: Column(
                    children: [
                       //icon và ordercode
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.assignment_outlined, color: darkBlue, ),
                           ),
                           Text("Mã đơn hàng: " + "${thisOrderDelivered.orderCode}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //ngày đặt hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Ngày đặt hàng: " + "${convertTime(thisOrderDelivered.createTime)}")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //ngày đặt hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Ngày nhận hàng: " + "${convertTime(thisOrderDelivered.completedTime as String)}")
                         ],
                       ),
                       SizedBox(height: 7,),
 
                   ]
                  ),
                ),
              ),
              SizedBox(height: 12,),
        
              //Địa chỉ nhận hàng
              Container(
                width: 100.w,
                height: 120,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  height: 100,
                  child: Column(
                    children: [
                       SizedBox(height: 10,),
                       //icon và text địa chỉ
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.location_on_outlined, color: darkBlue, size: 24,),
                           ),
                           Text("Địa chỉ nhận hàng", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //ntên cửa hàng + sdt
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Cửa hàng ${ Provider.of<Agency>(context, listen: false).name} - " + "${thisOrderDelivered.phone}")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //địa chỉ nhận
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             height: 50,
                           ),
                           SizedBox(
                             width: myWidth*0.85,
                             height: 50,
                             child: Text("${thisOrderDelivered.address}", overflow: TextOverflow.ellipsis, maxLines: 2,)
                           )
                         ],
                       )
                    ]
                  ),
                ),
              ),
              SizedBox(height: 12,),
        
              //Thông tin kiện hàng
              Container(
                width: 100.w,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  child: Column(
                    children: [
                       SizedBox(height: 10,),
                       //icon và text thông tin kiện hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.all_inbox_outlined, color: darkBlue, size: 24,),
                           ),
                           Text("Thông tin kiện hàng", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //List cart of order
                       ListView.builder(
                          itemCount: lstOrderDetail.length,              
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                              //
                              return Column(
                                children: [
                                  SizedBox(
                                    width: myWidth,
                                    child: Divider(),
                                  ),
                                  SizedBox(
                                     width: myWidth,
                                     height: 100,
                                     child: Row(children: [
                                        //Ảnh sản phẩm
                                        SizedBox(
                                          height: 100,
                                          width: myWidth*0.3,
                                          child: Image.network(
                                            getUrlFromLinkImg("${lstOrderDetail[index]['unit']['product']['linkImg']}")
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        //Tên, đơn vị + số lượng
                                        SizedBox(
                                          height: 100,
                                          width: myWidth*0.52,
                                          child: Column(
                                              children: [
                                              // tên sản phẩm + icon xóa cart
                                              SizedBox(
                                                 height: 30,
                                                 width: myWidth*0.52,
                                                 child: Row(
                                                   children: [
                                                     //tên sản phẩm
                                                     SizedBox(
                                                       width: myWidth*0.4,
                                                       child: Text(
                                                          "${lstOrderDetail[index]['unit']['product']['name']}", 
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),                                        
                                                       ),
                                                     ),
                                                     //icon xóa
                                                     SizedBox(
                                                       height: 30,
                                                       width: myWidth*0.1,
                                                       child: IconButton(
                                                          onPressed: () async {  
                                                            //xóa phần tử index của list order detail & list số lượng trong provider & list số lượng để check max                                          
                                                            setState(() {
                                                              lstOrderDetail.removeAt(index);
                                                              lstAmount.removeAt(index);
                                                              Provider.of<AmountReturnProvider>(context, listen: false).removeIndex(index);
                                                            });                                          
                                                          }, 
                                                          icon: Icon(Icons.cancel_presentation_sharp, size: 17,),
                                                          alignment: Alignment.topRight,
                                                       ),
                                                     ),                                                     
                                                   ],
                                                 )
                                              ),
                                              SizedBox(height: 5,),
                                              // Đơn vị
                                              SizedBox(
                                                 height: 18,
                                                 width: myWidth*0.52,
                                                 child: Text(
                                                    "Đơn vị: " + "${lstOrderDetail[index]['unit']['name']}", 
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 14, ),                                        
                                                 )
                                              ),   
                                              // Số lượng
                                              SizedBox(
                                                 height: 30,
                                                 width: myWidth*0.52,
                                                 child: Row(
                                                   children: [
                                                     //text số lượng
                                                     SizedBox(
                                                       width: myWidth*0.3,
                                                       child: Text(
                                                          "Số lượng: " + "${Provider.of<AmountReturnProvider>(context).lstAmount[index]}", 
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(fontSize: 14,),                                        
                                                       ),
                                                     ),
                                                     //text button thay đổi
                                                     GestureDetector(
                                                       //show bottom sheet thay đổi số lượng tại đây
                                                       onTap: (){
                                                          showModalBottomSheet<void>(
                                                            isDismissible: false,
                                                            useRootNavigator: true,
                                                            backgroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(10), topRight:  Radius.circular(10)),),
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return StatefulBuilder( builder: (BuildContext context, setState) =>
                                                                Container(
                                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                height: heightDevice/2 + MediaQuery.of(context).viewInsets.bottom,                                                         
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: <Widget>[
                                                                    // icon button xóa 
                                                                    SizedBox(
                                                                      width: 100.w,
                                                                      height: 30,
                                                                      child: IconButton(
                                                                        icon: Icon(Icons.cancel_presentation, size: 20,),
                                                                        alignment: Alignment.centerRight,
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5,),
                                                            
                                                                    // ảnh sp + tên + giá + đơn vị
                                                                    Container(
                                                                      width: myWidth,
                                                                      height: 80,
                                                                      child: Row(children: [
                                                                        SizedBox(width: 10,),
                                                                        //Ảnh sản phẩm
                                                                        SizedBox(
                                                                          height: 100,
                                                                          width: myWidth*0.3,
                                                                          child: Image.network(
                                                                             getUrlFromLinkImg("${lstOrderDetail[index]['unit']['product']['linkImg']}")
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10,),
                                                                        //Tên, xuất xứ và giá
                                                                        SizedBox(
                                                                          height: 100,
                                                                          width: myWidth*0.6,
                                                                          child: Column(
                                                                             children: [
                                                                                // tên sản phẩm
                                                                                SizedBox(
                                                                                    height: 30,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                       "${lstOrderDetail[index]['unit']['product']['name']}", 
                                                                                       maxLines: 1,
                                                                                       overflow: TextOverflow.ellipsis,
                                                                                       softWrap: false,
                                                                                       textAlign: TextAlign.left,
                                                                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),                                        
                                                                                    )
                                                                                ),
                                                                                // Đơn vị
                                                                                SizedBox(
                                                                                    height: 24,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "Đơn vị: " + "${lstOrderDetail[index]['unit']['name']}", 
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 12, ),                                        
                                                                                    )
                                                                                ),                                                                     
                                                                                // giá bán cho đại lý
                                                                                SizedBox(
                                                                                    height: 20,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "${lstOrderDetail[index]['price'].replaceAllMapped(reg, mathFunc)}" + "đ", 
                                                                                      maxLines: 1,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                                                                    )
                                                                                ),                                    
                                                                             ],),
                                                                      )
                                                                      ]),
                                                                    ),
                                                                
                                                                    Divider(),    
                                                                    //Nhập số lượng
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 100.w,
                                                                      child: Row(children: [
                                                                        SizedBox(width: 10.w,),
                                                                        // text nhập số lượng
                                                                        SizedBox(
                                                                          width: myWidth*0.6,
                                                                          height: 30,
                                                                          child: Column(
                                                                            children: [
                                                                              SizedBox(height: 8,),
                                                                              SizedBox(height: 20,width: myWidth*0.6, child: Text("Nhập số lượng", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                              SizedBox(height: 2,),
                                                                            ],
                                                                          )
                                                                        ),
                                                                        //text formfield điền số lượng hàng
                                                                        SizedBox(
                                                                          height: 30,
                                                                          width: 60, 
                                                                          child: Form(
                                                                            key: _formEnterAmountKey,
                                                                            child: TextFormField(
                                                                            controller: enternAmountController,        
                                                                          keyboardType: TextInputType.number,
                                                                          cursorHeight: 14,
                                                                          textAlignVertical: TextAlignVertical.center,
                                                                          style: TextStyle(fontSize: 14),
                                                                          validator: (value) {
                                                                             if (value == null || value.isEmpty) {
                                                                                return "trống";
                                                                             }
                                                                             return null;
                                                                          },  
                                                                          decoration:  InputDecoration(
                                                                             enabledBorder:  OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0),
                                                                                borderSide: BorderSide(color: darkGrey),
                                                                             ),
                                                                          )
                                                                        ),
                                                                      ),
                                                                   )
                                                                  ])
                                                                ),
                                                                Divider(),
                                                                //button cập nhật số lượng
                                                                SizedBox(height: 5,),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: 100.w,
                                                                  child: Row(children: [
                                                                    SizedBox(width: 10.w,),
                                                                    Container(
                                                                      height: 45,
                                                                      width: 80.w,
                                                                      child: ElevatedButton(           
                                                                        onPressed: () async {
                                                                           //validate số lượng có null không
                                                                           if (_formEnterAmountKey.currentState!.validate()){
                                                                              //check max tại đây, số lượng đặt không được vượt quá số lượng ban đầu
                                                                              if( int.parse(enternAmountController.text) > int.parse(lstAmount[index]) ) {
                                                                                Alert(
                                                                                  context: context,
                                                                                  type: AlertType.warning,
                                                                                  style: AlertStyle( titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                                                                  title: "Không được vượt quá số lượng đã giao",
                                                                                  buttons: [ DialogButton(
                                                                                    child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                    width: 100,
                                                                                  )],
                                                                                ).show();        
                                                                              } else{   
                                                                                  //update giá trị số lượng trong lstOrderDetail
                                                                                  lstOrderDetail[index]['quantity'] = enternAmountController.text; 
                                                                                  //update số lượng của chính index đó                                                                          
                                                                                  Provider.of<AmountReturnProvider>(context, listen: false).setNewAmount(index, enternAmountController.text); 
                                                                                  Navigator.pop(context);
                                                                              }
                                                                           }
                                                                           // cập nhật tổng tiền tại đây
                                                                           
                                                                           
                                                                        },
                                                                        child: Text("Cập nhật", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                                                        style: ButtonStyle(
                                                                            elevation: MaterialStateProperty.all(0),
                                                                            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                                )

                                                             ],
                                                           ),
                                                        ) );
                                                            },//builder
                                                          );//showmodal bottom sheet
                                                       },//onTap
                                                       child: Text(
                                                          "Thay đổi",
                                                          style: TextStyle(
                                                            color: Color(0xff4690ff),
                                                          ),
                                                       ),
                                                     )
                                                   ],
                                                 )
                                              ),         
                                            ],
                                          ),
                                      )
                                    ]),
                                   ),
                                ],
                              );
                          }),
                       //divider cuối cùng
                       SizedBox(
                         width: myWidth,
                         child: Divider(),
                       ), 
                    ]
                  ),
                ),
              ),
              SizedBox(height: 12,),

              //Thanh toán
              Container(
                width: 100.w,
                height: 120,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  height: 100,
                  child: Column(
                    children: [
                       SizedBox(height: 10,),
                       //icon visa và text Thanh toán
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.credit_card, color: darkBlue, size: 24,),
                           ),
                           Text("Thanh toán", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //Tổng tiên
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Tổng tiền: " + "${thisOrderDelivered.totalPayment.replaceAllMapped(reg, mathFunc)}đ")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //Hình thức thanh toán
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Hình thức thanh toán: $paymentType")
                         ],
                       ),
                    ]
                  ),
                ),
              ),
              SizedBox(height: 12,),

          ]),
      ),

      //bottom tiến hành trả hàng
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
                                  child: Text("Tổng tiền hoàn", style: TextStyle(color: Color(0xff544c4c), fontSize: 14))
                                )
                              )
                            ),
                            //Tổng tiền hoàn
                            SizedBox(
                              width: 60.w,
                              height: 24,
                              child: Text(
                                "${sumOfOrder.toString().replaceAllMapped(reg, mathFunc)}" + "đ", 
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
                          //button tiến hành trả hàng
                          child: ElevatedButton(
                              onPressed: () {
                                  //set list product gửi lên trong return order
                                  print(lstOrderDetail);
                                  Provider.of<ReturnProvider>(context, listen: false).setListProduct(lstOrderDetail);
                                  //move to điền thông tin
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoReturn(thisOrderDelivered.id ,sumOfOrder, thisOrderDelivered.extraInfoOfAddress, thisOrderDelivered.ward, thisOrderDelivered.district, thisOrderDelivered.province)));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiến hàng trả hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          

    );
  }


  // Hàm convert thời gian ở mã đơn hàng
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
  // Hàm convert thời gian ở trạng thái đơn
  String convertTimeState(String time){
    var timeConvert = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }  
  //hàm lấy ảnh cloudinary
  String getUrlFromLinkImg(String linkImg) {
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }    

}