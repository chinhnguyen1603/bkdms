import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';

class DetailDelivering extends StatefulWidget {
  late OrderInfo orderDeliveringInfo ;
  DetailDelivering(this.orderDeliveringInfo);
  
  @override
  State<DetailDelivering> createState() => DetailDeliveringState();
}

class DetailDeliveringState extends State<DetailDelivering> {
  //width trong detail = 90. width ở ngoài screen là 95
  double myWidth = 90.w;
  static const darkBlue = Color(0xff27214d);

  @override
  Widget build(BuildContext context) {
    OrderInfo thisOrderDelivering = widget.orderDeliveringInfo;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
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
                           Text("Ngày đặt hàng: " + "${convertTime(thisOrderDelivering.createTime)}")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //text đang giao hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Đang giao hàng", style: TextStyle(fontWeight: FontWeight.w300), )
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
                           Text("Hình thức thanh toán: ")
                         ],
                       ),
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
                         itemCount: 1,              
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
                                      width: myWidth*0.72,
                                      child: Text("Đơn hàng đã được xác nhận", style: TextStyle(color: Color(0xff40a292)),),
                                    ),
                                    SizedBox(width: 5,),
                                    //time
                                    SizedBox(
                                      child: Text("18-04-2022 \n 12:55", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Color(0xff544c4c)),),
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