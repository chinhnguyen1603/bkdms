import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/models/SaleOrder.dart';
import 'package:bkdms/services/ConsumerProvider.dart';


//widget lịch sử đơn tại đây
class SalesHistory extends StatefulWidget {
  @override
  State<SalesHistory> createState() => _SalesHistoryState();
}


class _SalesHistoryState extends State<SalesHistory> {
  static const darkGrey = Color(0xff544c4c);
  List<SaleOrder> lstSaleOrder = [];
  List<SaleOrder> lstSelectSaleOrder = [];
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    this.lstSaleOrder = Provider.of<ConsumerProvider>(context, listen: false).lstSaleOrder;
  }


 
  @override
  Widget build(BuildContext context) {
    //biến chiều rộng
    double myWidth = 90.w;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';    
    //     
    return Scaffold(
      appBar: AppBarTransparent(Colors.white, "Lịch sử đơn"),
      backgroundColor: Colors.white,

      //widget body 
      body: SingleChildScrollView( 
          child: Column(
            children: [
              SizedBox(width: 100.w,height: 5),
              //textbutton chọn ngày
              TextButton(
                onPressed: () async{
                  await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021), 
                    lastDate: DateTime(2023),
                  ).then((DateTime? value){
                      if(value != null) {
                        DateTime fromDate = DateTime.now();
                        fromDate = value;
                        final String date =  DateFormat('dd/MM/yyyy').format(fromDate);
                        //show toast
                        Fluttertoast.showToast(
                          msg: "Bạn vừa chọn $date",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14.0
                        );
                        //build list mới từ date đã chọn
                        setState(() {
                          lstSelectSaleOrder = lstSaleOrder
                            .where((element) =>
                               convertTime(element.createTime).contains(convertTime("$value")))
                            .toList();  
                          _isSelecting = true;   
                        });         
                      } 
                  });
                  print(lstSelectSaleOrder);
                }, 
                child: Text("Xem theo ngày", style: TextStyle(color: Color(0xff7b2626)),)
              ),
              SizedBox(height: 5),
             
              //Listview lịch sử đơn
              _isSelecting
                //khi select ngày thì chỉ ra đơn ngày đó
                ?ListView.builder(
                       reverse: true,
                       itemCount: lstSelectSaleOrder.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã bán
                             GestureDetector(
                               onTap: (){
                               },
                               //chi tiết đơn
                               child: Container(
                                  width: 90.w,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff1c3a80)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(28, 58, 128, 0.1),
                                        blurRadius: 10,        
                                        offset: Offset(0,0), 
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(width: 100.w, height: 8,),
                                      SizedBox(
                                        width: myWidth,
                                        child: Text(
                                          "Đơn hàng #${lstSelectSaleOrder[index].orderCode}", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color(0xfffa620c), fontSize: 17, fontWeight: FontWeight.w600),
                                        ), 
                                      ),
                                      SizedBox(width: 100.w, height: 5,),
                                      //Row tông tiền + thời gian
                                      SizedBox(
                                        height: 20,
                                        width: myWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //tổng tiền
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.attach_money, color: Color(0xff2fab73),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${lstSelectSaleOrder[index].totalPrice.replaceAllMapped(reg, mathFunc)}đ",
                                                        style: TextStyle(color: darkGrey),              
                                                      ),
                                                    ],
                                                  )
                                                ]
                                              )
                                            ),
                                            SizedBox(width: myWidth*0.3,),
                                            //thời gian hoàn thành
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.history, color: Color(0xff7b2626),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${convertTime(lstSelectSaleOrder[index].createTime)}",
                                                        style: TextStyle(color: darkGrey),
                                                        textAlign: TextAlign.right,                        
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(),
                                      //tên + sdt khách hàng
                                      SizedBox(
                                        width: myWidth,
                                        height: 30,
                                        child: Text(
                                          "Khách hàng: ${lstSelectSaleOrder[index].name}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize:16)
                                        )
                                      ),
                                      SizedBox(
                                        width: myWidth,
                                        height: 30,
                                        child: Text(
                                          "SDT: ${lstSelectSaleOrder[index].phone}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize:16)
                                        )
                                      ),                                      
                                   ],
                                  ),
                               ),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                )
  
                //mặc định ban đầu là tất cả ngày
                :ListView.builder(
                       reverse: true,
                       itemCount: lstSaleOrder.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã bán
                             GestureDetector(
                               onTap: (){
                               },
                               //chi tiết đơn
                               child: Container(
                                  width: 90.w,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff1c3a80)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(28, 58, 128, 0.1),
                                        blurRadius: 10,        
                                        offset: Offset(0,0), 
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(width: 100.w, height: 8,),
                                      SizedBox(
                                        width: myWidth,
                                        child: Text(
                                          "Đơn hàng #${lstSaleOrder[index].orderCode}", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color(0xfffa620c), fontSize: 17, fontWeight: FontWeight.w600),
                                        ), 
                                      ),
                                      SizedBox(width: 100.w, height: 5,),
                                      //Row tông tiền + thời gian
                                      SizedBox(
                                        height: 20,
                                        width: myWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //tổng tiền
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.attach_money, color: Color(0xff2fab73),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${lstSaleOrder[index].totalPrice.replaceAllMapped(reg, mathFunc)}đ",
                                                        style: TextStyle(color: darkGrey),              
                                                      ),
                                                    ],
                                                  )
                                                ]
                                              )
                                            ),
                                            SizedBox(width: myWidth*0.3,),
                                            //thời gian hoàn thành
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.history, color: Color(0xff7b2626),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${convertTime(lstSaleOrder[index].createTime)}",
                                                        style: TextStyle(color: darkGrey),
                                                        textAlign: TextAlign.right,                        
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(),
                                      //tên + sdt khách hàng
                                      SizedBox(
                                        width: myWidth,
                                        height: 30,
                                        child: Text(
                                          "Khách hàng: ${lstSaleOrder[index].name}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize:16)
                                        )
                                      ),
                                      SizedBox(
                                        width: myWidth,
                                        height: 30,
                                        child: Text(
                                          "SDT: ${lstSaleOrder[index].phone}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize:16)
                                        )
                                      ),                                      
                                   ],
                                  ),
                               ),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                )
 
            ]
          )
      ),
 
    );    
  }

  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }


}