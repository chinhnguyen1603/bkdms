import 'package:bkdms/components/AppBarGrey.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';

class DetailConfirm extends StatefulWidget {
  late OrderInfo orderInfo ;
  DetailConfirm(this.orderInfo);
  @override
  State<DetailConfirm> createState() => DetailConfirmState();
}

class DetailConfirmState extends State<DetailConfirm> {
  double myWidth = 90.w;
  static const darkBlue = Color(0xff27214d);

  @override
  Widget build(BuildContext context) {
    OrderInfo thisOrderInfo = widget.orderInfo;
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
                           Text("Mã đơn hàng: " + "${thisOrderInfo.orderCode}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),)
                         ],
                       ),
                       SizedBox(height: 5,),
                       //ngày đặt hàng
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Ngày đặt hàng: " + "${convertTime(thisOrderInfo.createTime)}")
                         ],
                       ),
                       SizedBox(height: 7,),
                       //đang chờ
                       Row(
                         children: [
                           SizedBox(
                             width: myWidth*0.12,
                           ),
                           Text("Đang chờ xác nhận", style: TextStyle(fontWeight: FontWeight.w300),)
                         ],
                       )
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
                           Text("Cửa hàng ${ Provider.of<Agency>(context, listen: false).name} - " + "${thisOrderInfo.phone}")
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
                             child: Text("${thisOrderInfo.address}", overflow: TextOverflow.ellipsis, maxLines: 2,  style: TextStyle(fontWeight: FontWeight.w300),)
                           )
                         ],
                       )
                    ]
                  ),
                ),
              ),
              SizedBox(height: 12,),
        
              //Địa chỉ nhận hàng
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
                          itemCount: thisOrderInfo.orderDetails.length,              
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                 width: myWidth,
                                 height: 80,
                                 child: Row(children: [
                                    //Ảnh sản phẩm
                                    SizedBox(
                                      height: 100,
                                      width: myWidth*0.3,
                                      child: Image.network(
                                        getUrlFromLinkImg("${thisOrderInfo.orderDetails[index]['unit']['product']['linkImg']}")
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    //Tên, đơn vị + số lượng
                                    SizedBox(
                                      height: 100,
                                      width: myWidth*0.5,
                                      child: Column(
                                          children: [
                                          // tên sản phẩm
                                          SizedBox(
                                             height: 30,
                                             width: myWidth*0.5,
                                             child: Text(
                                                "${thisOrderInfo.orderDetails[index]['unit']['product']['name']}", 
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),                                        
                                             )
                                          ),
                                          // Đơn vị
                                          SizedBox(
                                             height: 25,
                                             width: myWidth*0.5,
                                             child: Text(
                                           "Đơn vị: " + "${thisOrderInfo.orderDetails[index]['unit']['name']}", 
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                           softWrap: false,
                                           textAlign: TextAlign.left,
                                           style: TextStyle(fontSize: 14, ),                                        
                                        )
                                      ),   
                                      // Số lượng
                                      SizedBox(
                                        height: 25,
                                        width: myWidth*0.5,
                                        child: Text(
                                           "Số lượng: " + "${thisOrderInfo.orderDetails[index]['quantity']}", 
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                           softWrap: false,
                                           textAlign: TextAlign.left,
                                           style: TextStyle(fontSize: 14,),                                        
                                        )
                                      ),                                                                                                       
                                    ],
                                   ),
                                  )
                                ]),
                               );
                          }),
                        Divider(),
                   ]
                  ),
                ),
              )

          ]),
      ),
    );
  }


  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(time).toLocal());
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