import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class Delivering extends StatefulWidget {
  const Delivering({ Key? key }) : super(key: key);

  @override
  State<Delivering> createState() => DeliveringState();
}


class DeliveringState extends State<Delivering> {
  List<String> lstDelivering = [];
  static const darkGrey = Color(0xff544c4c);
  static const textColor = Color(0xff27214d);
  //widget
  @override
  Widget build(BuildContext context) {
    //width dùng trong container
    double myWidth = 95.w;    
    //check if has or not order, phải để trong widget để build lại khi list change
    bool isHasOrder = true;
    if(lstDelivering.length !=0 ) {
      isHasOrder = true;
    }
    //
    return Container(
      child: isHasOrder 
      //có đơn
      ? Container(
         child: Column( children: [
            SizedBox(width: 100.w, height: 12,),
            //UI List Order
            ListView.builder(
               itemCount:3,              
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
                         //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDelivering(lstDelivering[index])));
                       },
                       child: Container(
                         width: 100.w,
                         height: 210,
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
                                        "Đơn hàng #" + "{lstDelivering[index].orderCode}",
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
                                        "{convertTime(lstDelivering[index].createTime)}",
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
                                      getUrlFromLinkImg("{lstDelivering[index].orderDetails[0]['unit']['product']['linkImg']}")
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
                                        "{lstDelivering[index].orderDetails[0]['unit']['product']['name']}", 
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
                                         "Đơn vị: " + "{lstDelivering[index].orderDetails[0]['unit']['name']}", 
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
                                         "Số lượng: " + "{lstDelivering[index].orderDetails[0]['quantity']}", 
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
                                         SizedBox(width: myWidth*0.05),
                                         SizedBox(
                                           width: myWidth*0.1,
                                           height: 20,
                                           child: Image.asset("assets/box.png",),
                                         ),
                                         SizedBox(width: 2,),
                                         Text("{lstDelivering[index].orderDetails.length} sản phẩm", style: TextStyle(color: Color(0xff7b2626)),)
                                       ],
                                     ),
                                   ),
                                   SizedBox(width: myWidth*0.25,),
                                   //tổng tiền
                                   SizedBox(
                                     width: myWidth*0.35,
                                     child: Row(
                                       children: [
                                         SizedBox(
                                           width: myWidth*0.08,
                                           height: 20,
                                           child: Image.asset("assets/totalMoney.png", alignment: Alignment.centerRight, width: myWidth*0.1,),
                                         ),
                                         SizedBox(
                                           width: myWidth*0.22,
                                           child: Text(
                                             "{lstDelivering[index].totalPayment.replaceAllMapped(reg, mathFunc)}", 
                                             textAlign: TextAlign.center,
                                             style: TextStyle(color: Color(0xff7b2626)),
                                           )
                                         )
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Divider(),
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
    var timeConvert = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
  //hàm lấy ảnh cloudinary
  String getUrlFromLinkImg(String linkImg) {      //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }    


} 