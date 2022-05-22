import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/InfoShipDelivering.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/OrderInfo.dart';

class DetailDelivering extends StatefulWidget {
  late OrderInfo orderDeliveringInfo ;
  DetailDelivering(this.orderDeliveringInfo);
  
  @override
  State<DetailDelivering> createState() => _DetailDeliveringState();
}

class _DetailDeliveringState extends State<DetailDelivering> {
  //width trong detail = 90. width ở ngoài screen là 95
  double myWidth = 90.w;
  static const darkBlue = Color(0xff27214d);
  //list thông tin vận chuyển 
  List<dynamic> lstWayBills = [];
  //tình trạng đơn đang giao hay là giao lỗi
  String statusOfOrder ="Đang giao hàng";  
  
  @override
  Widget build(BuildContext context) {
    OrderInfo thisOrderDelivering = widget.orderDeliveringInfo;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //lấy hình thức thanh toán của đơn
    String paymentType = "Thanh toán nợ";
    if(thisOrderDelivering.paymentType == "COD_PAYMENT") {
      paymentType = "Thanh toán COD";
    }
    //list trạng thái đơn hàng + logic
    List<Map> lstStatus = []; 
      lstStatus.add({
        "status": "Đặt đơn hàng và chờ xác nhận.",
        "time": "${convertTimeState(thisOrderDelivering.createTime)}"
      });     
    if(thisOrderDelivering.approvedTime != null){
      lstStatus.add({
        "status": "Đơn hàng đã được xác nhận từ nhà cung cấp.",
        "time": "${convertTimeState(thisOrderDelivering.approvedTime as String)}"
      });     
    } 
    if(thisOrderDelivering.deliveredTime != null){
      lstStatus.add({
        "status": "Shipper thông báo đã giao đơn hàng.",
        "time": "${convertTimeState(thisOrderDelivering.deliveredTime as String)}"
      });     
    }
    if(thisOrderDelivering.completedTime != null){
      lstStatus.add({
        "status": "Người dùng xác nhận đã nhận đơn hàng.",
        "time": "${convertTimeState(thisOrderDelivering.completedTime as String)}"
      });     
    } 
    //lấy thông tin vận chuyển
    if(widget.orderDeliveringInfo.wayBills != null){
      lstWayBills = widget.orderDeliveringInfo.wayBills as List<dynamic>;
    }  
    //lấy tình trạng đang giao hàng hay giao bị lỗi
    if (thisOrderDelivering.orderStatus == "DELIVERY_FAILED"){
      statusOfOrder = "Giao hàng lỗi";
    }
    //
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
                           Text("Mã đơn hàng: " + "${thisOrderDelivering.orderCode}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //ngày đặt hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Thời gian đặt đơn: " + "${convertTime(thisOrderDelivering.createTime)}")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //text đang giao hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("$statusOfOrder", style: TextStyle(fontWeight: FontWeight.w300), )
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
                           Text("Cửa hàng ${ Provider.of<Agency>(context, listen: false).name} - " + "${thisOrderDelivering.phone}")
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
                             child: Text("${thisOrderDelivering.address}", overflow: TextOverflow.ellipsis, maxLines: 2,)
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
                          itemCount: thisOrderDelivering.orderDetails.length, //thisOrderDelivering.orderDetails.length,              
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
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
                                            getUrlFromLinkImg("${thisOrderDelivering.orderDetails[index]['unit']['product']['linkImg']}")
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        //Tên, đơn vị + số lượng
                                        SizedBox(
                                          height: 100,
                                          width: myWidth*0.52,
                                          child: Column(
                                              children: [
                                              // tên sản phẩm
                                              SizedBox(
                                                 height: 24,
                                                 width: myWidth*0.52,
                                                 child: Text(
                                                    "${thisOrderDelivering.orderDetails[index]['unit']['product']['name']}", 
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),                                        
                                                 )
                                              ),
                                              // Đơn vị
                                              SizedBox(
                                                 height: 22,
                                                 width: myWidth*0.52,
                                                 child: Text(
                                                    "Đơn vị: " + "${thisOrderDelivering.orderDetails[index]['unit']['name']}", 
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 12, ),                                        
                                                 )
                                              ),   
                                              // Số lượng
                                              SizedBox(
                                                 height: 22,
                                                 width: myWidth*0.52,
                                                 child: Text(
                                                    "Số lượng: " + "${thisOrderDelivering.orderDetails[index]['quantity']}", 
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 12,),                                        
                                                 )
                                              ),                                                                                                       
                                              // Thành tiền
                                              SizedBox(
                                                 height: 22,
                                                 width: myWidth*0.52,
                                                 child: Text(
                                                    "Thành tiền: " + "${thisOrderDelivering.orderDetails[index]['totalPrice'].replaceAllMapped(reg, mathFunc)}đ", 
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 12,),                                        
                                                 )
                                              ),                                              ],
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
                           Text("Tổng tiền: " + "${thisOrderDelivering.totalPayment.replaceAllMapped(reg, mathFunc)}đ")
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

              //Thông tin vận chuyển
              Container(
                width: 100.w,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  child: Column(
                    children: [
                       SizedBox(height: 10,),
                       //icon xe tải và text Thông tin vận chuyển
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.local_shipping_outlined, color: darkBlue, size: 24,),
                           ),
                           SizedBox(
                             width: myWidth*0.66,
                             child: Text("Thông tin vận chuyển", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                           ),
                           SizedBox(
                             child: TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoShipDelivering(lstWayBills)));
                                },
                                child: Text("Xem thêm", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff44690ff)),)                   
                             ),
                           )
                         ],
                       ),
                       SizedBox(height: 5,),
                       ListView.builder(
                          itemCount: lstWayBills.length,              
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            //tình trạng vận đơn
                            String statusBill ="";
                            if(lstWayBills[index]['status'] != null ){
                              if(lstWayBills[index]['status'] == "SHIPPED") {
                                 statusBill = "Đã vận chuyển";
                              }
                              if(lstWayBills[index]['status'] == "SHIPPING") {
                                 statusBill = "Đang vận chuyển";
                              }    
                              if(lstWayBills[index]['status'] == "SHIPPING_PROBLEM") {
                                 statusBill = "Vận chuyển lỗi";
                              }                                                          
                            }
                            //
                            return Column(
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: Row(
                                    children: [
                                      SizedBox(width: myWidth*0.12),
                                      Text("Mã vận đơn: ${lstWayBills[index]['receiptCode']}"),
                                    ],
                                  )
                                ),
                                SizedBox(height: 3,),
                                //tình trạng vận đơn
                                SizedBox(
                                  width: 100.w,
                                  child: Row(
                                    children: [
                                      SizedBox(width: myWidth*0.12,),
                                      Text("Tình trạng: $statusBill", style: TextStyle(color: Color(0xfff53838)),),
                                    ],
                                  ),
                                ),                               
                                SizedBox(
                                  width: myWidth,
                                  child: Divider(),
                                )                                
                              ],
                              
                            );
                          }
                       )
                   ]
                  ),
                ),
              ),
              SizedBox(height: 12,),


              //Trạng thái đơn hàng
              Container(
                width: 100.w,
                color: Colors.white,
                child: SizedBox(
                  width: myWidth,
                  child: Column(
                    children: [
                       SizedBox(height: 10,),
                       //icon và text trạng thái đơn hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                             child: Icon(Icons.flag_outlined, color: darkBlue, size: 24,),
                           ),
                           Text("Trạng thái đơn hàng", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(
                          width: myWidth,
                          child: Divider(),
                       ),
                       //list view trạng thái
                       ListView.builder(
                         itemCount: lstStatus.length,              
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: myWidth*0.12,
                                      child: Icon(Icons.arrow_right_rounded, color: darkBlue, size: 18,),
                                    ),
                                    //text trạng thái 
                                    SizedBox(
                                      width: myWidth*0.7,
                                      child: Text("${lstStatus[index]['status']}", style: TextStyle(color: Color(0xff40a292)),),
                                    ),
                                    //time
                                    SizedBox(
                                      child: Text("${lstStatus[index]['time']}",textAlign: TextAlign.center ,style: TextStyle(fontSize: 12, color: Color(0xff544c4c)),),
                                    )
                                  ], 
                                ),
                                SizedBox(
                                  width: myWidth,
                                  child: Divider(),
                                )
                              ],
                            );
                         }
                       )
                   ]
                  ),
                ),
              ),
              SizedBox(height: 12,),

          ]),
      ),
    );
  }


  // Hàm convert thời gian ở mã đơn hàng
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
  // Hàm convert thời gian ở trạng thái đơn
  String convertTimeState(String time){
    var timeConvert = DateFormat('dd-MM-yyyy \n HH:mm').format(DateTime.parse(time).toLocal());
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