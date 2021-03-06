import 'package:bkdms/screens/home_screens/order_status_screen/DetailDelivered.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:bkdms/models/OrderInfo.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';



class Delivered extends StatefulWidget {
  const Delivered({ Key? key }) : super(key: key);

  @override
  State<Delivered> createState() => _DeliveredState();
}


class _DeliveredState extends State<Delivered> {  
  List<OrderInfo> lstOrder = [];
  static const darkGrey = Color(0xff544c4c);
  static const textColor = Color(0xff27214d);
  static const dialogColor = Color(0xff4690FF);
  late Future _myFuture;  
  
  @override
  void initState() {
     super.initState();
     //mỗi lần click vào tab là get order
     Agency user = Provider.of<Agency>(context, listen: false);
     _myFuture = Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id);  
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }


  //widget
  @override
  Widget build(BuildContext context) {
    //update lstDelivered show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstWaitOrder change
    List<OrderInfo> lstDelivered = [];
    for( var order in lstOrder) {
        if ((order.deliveredTime != null || order.completedTime !=null) && order.type == "PURCHASE_ORDER"){
          lstDelivered.add(order);
        }
    }  
    //width dùng trong container
    double myWidth = 95.w;
    //check if has or not order, phải để trong widget để build lại khi list change
    bool isHasOrder = false;
    if(lstDelivered.length !=0 ) {
      isHasOrder = true;
    }
    //
    return FutureBuilder<void>(
      future: _myFuture,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: isHasOrder 
          //có đơn
              ? Container(
                 child: Column( children: [
                    SizedBox(width: 100.w, height: 12,),
                    //UI List Order
                    ListView.builder(
                       itemCount:lstDelivered.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         //thêm dấu chấm vào giá sản phẩm
                         RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                         String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                         //check đơn đã được xác nhận từ agency chưa tại đây. Mặc định là chưa
                         bool isCompleted = false;
                         if(lstDelivered[index].completedTime != null){
                           isCompleted = true;
                         }
                         //widget
                         return isCompleted
                          //dấu hỏi là đơn đã được xác nhận
                          ?Column(
                           children: [   
                             //container chứa chi tiết đơn                 
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDelivered(lstDelivered[index])));
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
                                                "Mã #" + "${lstDelivered[index].orderCode}",
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            //time đặt
                                            SizedBox(
                                              width: myWidth*0.3,
                                              child: Text(
                                                "${convertTime(lstDelivered[index].createTime)}",
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
                                              getUrlFromLinkImg("${lstDelivered[index].orderDetails[0]['unit']['product']['linkImg']}")
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
                                                "${lstDelivered[index].orderDetails[0]['unit']['product']['name']}", 
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
                                                 "Đơn vị: " + "${lstDelivered[index].orderDetails[0]['unit']['name']}", 
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
                                                 "Số lượng: " + "${lstDelivered[index].orderDetails[0]['quantity']}", 
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
                                                 Text("${lstDelivered[index].orderDetails.length} sản phẩm", style: TextStyle(color: textColor),)
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
                                                     "${lstDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}", 
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
                                     //text Đã hoàn tất giao hàng
                                     SizedBox(
                                        width: myWidth*0.94,
                                        child: Text("Đã hoàn tất giao hàng", textAlign: TextAlign.center ,style: TextStyle(color: textColor),),
                                     )                               ],
                                 ),
                               ),
                             ),
                             SizedBox(width: 100.w, height: 12,),   
                          ])

                          //dấu chấm là đơn chưa được xác nhận
                          :Column(
                           children: [   
                             //container chứa chi tiết đơn                 
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDelivered(lstDelivered[index])));
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
                                                "Mã #" + "${lstDelivered[index].orderCode}",
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            //time đặt       
                                            SizedBox(
                                              width: myWidth*0.3,
                                              child: Text(
                                                "${convertTime(lstDelivered[index].createTime)}",
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
                                              getUrlFromLinkImg("${lstDelivered[index].orderDetails[0]['unit']['product']['linkImg']}")
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
                                                "${lstDelivered[index].orderDetails[0]['unit']['product']['name']}", 
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
                                                 "Đơn vị: " + "${lstDelivered[index].orderDetails[0]['unit']['name']}", 
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
                                                 "Số lượng: " + "${lstDelivered[index].orderDetails[0]['quantity']}", 
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
                                                 Text("${lstDelivered[index].orderDetails.length} sản phẩm", style: TextStyle(color: Color(0xff7b2626)),)
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
                                                     "${lstDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}", 
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
                                     //Button xác nhận nhận hàng
                                     SizedBox(
                                       height: 30,
                                       width: myWidth*0.4,
                                       child: ElevatedButton(
                                          onPressed: (){
                                            //dialog xác nhận
                                            Alert(
                                              context: context,
                                              type: AlertType.warning,
                                              desc: "Xác nhận đã nhận được hàng cho đơn này?",
                                              buttons: [
                                              DialogButton(
                                                child: Text("Hủy bỏ", style: TextStyle(color: dialogColor, fontSize: 18),),
                                                onPressed: () => Navigator.pop(context),
                                                color: Colors.white,
                                              ),
                                              //post xác nhận tại đây
                                              DialogButton(
                                                child: Text("Đồng ý", style: TextStyle(color: Colors.white, fontSize: 18),),
                                                onPressed: () async {
                                                  await showDialog (
                                                      context: context,
                                                      builder: (context) =>
                                                        FutureProgressDialog(receiveThisOrder(lstDelivered[index].id),),
                                                  ); 
                                                  //ẩn pop-up
                                                  Navigator.pop(context);
                                                },
                                                color: dialogColor,
                                              )
                                              ],
                                            ).show();
                                          }, 
                                          child: Text("Xác nhận đơn"),
                                          style: ButtonStyle(
                                             elevation: MaterialStateProperty.all(0),
                                             backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff7b2626)),
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

  // hàm xác nhận đơn
  Future receiveThisOrder( String orderId) {
    return Future(() async {
    //gọi provide order delete sau đó get lại
    Agency user = Provider.of<Agency>(context, listen: false);
    await Provider.of<OrderProvider>(context, listen: false).receiveOrder(user.token, user.workspace, user.id, orderId)
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