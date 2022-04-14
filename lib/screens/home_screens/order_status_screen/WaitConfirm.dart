import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/DetailConfirm.dart';
import 'package:bkdms/services/OrderProvider.dart';

class WaitConfirm extends StatefulWidget {
  const WaitConfirm({ Key? key }) : super(key: key);

  @override
  State<WaitConfirm> createState() => WaitConfirmState();
}



class WaitConfirmState extends State<WaitConfirm> {
  List<OrderInfo> lstOrder = [];
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
    List<OrderInfo> lstWaitOrder = [];
    for( var order in lstOrder) {
        if(order.orderStatus == "WAITING_FOR_APPROVED" && order.type == "PURCHASE_ORDER"){
          lstWaitOrder.add(order);
        }
    }
    //width dùng trong container
    double myWidth = 95.w;
    //check if has or not order, mỗi lần update tự đặt isHasOrder = false, nếu có list thì về true
    bool isHasOrder = false;
    if(lstWaitOrder.length !=0 ) {
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
               itemCount:lstWaitOrder.length,              
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
                         Navigator.push(context, MaterialPageRoute(builder: (context) => DetailConfirm(lstWaitOrder[index])));
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
                                        "Đơn hàng #" + "${lstWaitOrder[index].orderCode}",
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
                                        "${convertTime(lstWaitOrder[index].createTime)}",
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
                                      getUrlFromLinkImg("${lstWaitOrder[index].orderDetails[0]['unit']['product']['linkImg']}")
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
                                        "${lstWaitOrder[index].orderDetails[0]['unit']['product']['name']}", 
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
                                         "Đơn vị: " + "${lstWaitOrder[index].orderDetails[0]['unit']['name']}", 
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
                                         "Số lượng " + "${lstWaitOrder[index].orderDetails[0]['quantity']}", 
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
                                         Text("${lstWaitOrder[index].orderDetails.length} sản phẩm", style: TextStyle(color: Color(0xff7b2626)),)
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
                                           width: myWidth*0.1,
                                           height: 20,
                                           child: Image.asset("assets/totalMoney.png", alignment: Alignment.centerRight, width: myWidth*0.1,),
                                         ),
                                         SizedBox(
                                           width: myWidth*0.22,
                                           child: Text(
                                             "${lstWaitOrder[index].totalPayment.replaceAllMapped(reg, mathFunc)}", 
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
                             //Button Hủy đơn hàng
                             SizedBox(
                               height: 30,
                               width: myWidth*0.3,
                               child: ElevatedButton(
                                  onPressed: (){
                                    //dialog xác nhận
                                    Alert(
                                      context: context,
                                      type: AlertType.warning,
                                      desc: "Bạn có chắc chắn muốn hủy đơn không?",
                                      buttons: [
                                      DialogButton(
                                        child: Text("Hủy bỏ", style: TextStyle(color: dialogColor, fontSize: 18),),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.white,
                                      ),
                                      //delete order tại đây
                                      DialogButton(
                                        child: Text("Xác nhận", style: TextStyle(color: Colors.white, fontSize: 18),),
                                        onPressed: () async {
                                          await showDialog (
                                              context: context,
                                              builder: (context) =>
                                                FutureProgressDialog(deleteThisOrder(lstWaitOrder[index].id), message: Text('Đang xóa...', style: TextStyle(color:Color(0xffe2dddd)))),
                                          );
                                          //ẩn pop-up
                                          Navigator.pop(context);
                                        },
                                        color: dialogColor,
                                      )
                                      ],
                                    ).show();
                                  }, 
                                  child: Text("Hủy đơn"),
                                  style: ButtonStyle(
                                     elevation: MaterialStateProperty.all(0),
                                     backgroundColor:  MaterialStateProperty.all<Color>(Color(0xffffa451)),
                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0),)
                                     )
                                  ),
                               )
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
    var timeConvert = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
  //hàm lấy ảnh cloudinary
  String getUrlFromLinkImg(String linkImg) {
        final cloudinary = Cloudinary("975745475279556", "S9YIG_sABPRTmZKb0mGNTiJsAkg", "di6dsngnr");
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }    

  
  // hàm add cart rồi get, update số lượng sản phẩm
  Future deleteThisOrder( int orderId) {
    return Future(() async {
    //gọi provide order delete sau đó get lại
    Agency user = Provider.of<Agency>(context, listen: false);
    await Provider.of<OrderProvider>(context, listen: false).deleteOrder(user.token, user.workspace, user.id, orderId)
     .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi delete order future dialog");
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
      })
      .then((value) async {
          //update lại màn hình đơn hàng
          await Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id);
      });    
    });
  }   

}