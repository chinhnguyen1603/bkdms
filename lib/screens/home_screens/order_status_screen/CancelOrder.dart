import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/OrderProvider.dart';


class CancelOrder extends StatefulWidget {
  const CancelOrder({ Key? key }) : super(key: key);

  @override
  State<CancelOrder> createState() => CancelOrderState();
}


class CancelOrderState extends State<CancelOrder> {  
  List<OrderInfo> lstOrder= [];
  static const darkGrey = Color(0xff544c4c);
  static const textColor = Color(0xff27214d);
  static const dialogColor = Color(0xff4690FF);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }

  //widget 
  @override
  Widget build(BuildContext context) {
    //update lstOrder show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstOrder change
    List<OrderInfo> lstCancelOrder = [];
    for( var order in lstOrder) {
        if(order.orderStatus == "CANCELLED_FROM_AGENCY" && order.type == "PURCHASE_ORDER"){
          lstCancelOrder.add(order);
        }
    }
    //width dùng trong container
    double myWidth = 95.w;
    //check if has or not order, mỗi lần update tự đặt isHasOrder = false, nếu có list thì về true
    bool isHasOrder = false;
    if(lstCancelOrder.length !=0 ) {
      isHasOrder = true;
    }
    //
    return SingleChildScrollView(
      child: isHasOrder 
      //có đơn
      ? Container(
         child: Column( children: [
            SizedBox(width: 100.w, height: 12,),
            //UI List Order
            ListView.builder(
               //đảo ngược cho hợp với thời gian
               reverse: true,
               itemCount:lstCancelOrder.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                 //thêm dấu chấm vào giá sản phẩm
                 RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                 String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                 //widget
                 return Column(
                   children: [   
                     //container chứa chi tiết đơn                 
                     GestureDetector(
                       onTap: (){
                         //
                       },
                       child: Container(
                         width: 100.w,
                         height: 245,
                         color: Colors.white,
                         child: Column(
                           children: [
                             SizedBox(width: 100.w, height: 8,),
                             //Ordercode + time đặt
                             SizedBox(
                               width: myWidth,
                               height: 20,
                               child: Row(
                                 children: [
                                    //icon bookmark
                                    SizedBox(
                                      width: myWidth*0.1, 
                                      child: Icon(
                                        Icons.bookmark,
                                        color: darkGrey,
                                        size: 20,
                                      ),
                                    ),
                                    //Order code
                                    SizedBox(
                                      width: myWidth*0.6,
                                      child:  Text(
                                        "Đơn hàng #" + "${lstCancelOrder[index].orderCode}",
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    //time đặt         
                                    SizedBox(
                                      width: myWidth*0.3,
                                      child: Text(
                                        "${convertTime(lstCancelOrder[index].cancelledTimeByAgency as String)}",
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),                                                               
                                 ],
                               ),
                             ),
                             Divider(),
                             //Ảnh + tên + đơn giá + số lượng + thành tiền list[0]
                             SizedBox(
                               width: myWidth,
                               height: 80,
                               child: Row(children: [
                                  //Ảnh sản phẩm
                                  SizedBox(
                                    height: 100,
                                    width: myWidth*0.3,
                                    child: Image.network(
                                      getUrlFromLinkImg("${lstCancelOrder[index].orderDetails[0]['unit']['product']['linkImg']}")
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
                                        "${lstCancelOrder[index].orderDetails[0]['unit']['product']['name']}", 
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
                                         "Đơn vị: " + "${lstCancelOrder[index].orderDetails[0]['unit']['name']}", 
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
                                         "Số lượng " + "${lstCancelOrder[index].orderDetails[0]['quantity']}", 
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
                             ),
                             Divider(),
                             //Text xem thêm sản phẩm
                             Text("Xem thêm", style: TextStyle(color: darkGrey),),
                             Divider(),
                             //Số lượng sản phẩm + tổng tiền
                             SizedBox(
                               width: myWidth,
                               height: 20,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   //số lượng sản phẩm
                                   SizedBox(
                                     width: myWidth*0.4,
                                     child: Row(
                                       children: [
                                         SizedBox(
                                           width: myWidth*0.1,
                                           height: 20,
                                           child: Image.asset("assets/box.png",),
                                         ),
                                         SizedBox(width: 5,),
                                         Text("${lstCancelOrder[index].orderDetails.length} sản phẩm", style: TextStyle(color: textColor),)
                                       ],
                                     ),
                                   ),
                                   SizedBox(width: myWidth*0.2,),
                                   //tổng tiền
                                   SizedBox(
                                     width: myWidth*0.4,
                                     child: Row(
                                       children: [
                                         SizedBox(
                                           width: myWidth*0.15,
                                           height: 20,
                                           child: Image.asset("assets/totalMoney.png", alignment: Alignment.centerRight,),
                                         ),
                                         SizedBox(
                                           width: myWidth*0.22,
                                           child: Text(
                                             "${lstCancelOrder[index].totalPayment.replaceAllMapped(reg, mathFunc)}", 
                                             textAlign: TextAlign.center,
                                             style: TextStyle(color: textColor),
                                           )
                                         )
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Divider(),
                             //Button Hủy đơn hàng
                             SizedBox(
                               width: myWidth*0.9,
                               child: Text("Đơn hàng được hủy bởi người dùng", textAlign: TextAlign.left ,style: TextStyle(color: textColor),),
                             )
                           ],
                         ),
                       ),
                     ),
                     SizedBox(width: 100.w, height: 12,),   
                 ]);
               }
            )
         ])
        )       
      //không có đơn nào
      : Container(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 100,),
            Image.asset("assets/iconOrder.png", width: 100,),
            SizedBox(height: 10,),
            Text("Chưa có đơn hàng")
          ]
        )
      )
    );
  }

  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(time));
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