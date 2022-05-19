import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/OrderInfo.dart';
import 'package:bkdms/services/OrderProvider.dart';

class DebtHistory extends StatefulWidget {
  const DebtHistory({ Key? key }) : super(key: key);

  @override
  State<DebtHistory> createState() => _DebtHistoryState();
}

class _DebtHistoryState extends State<DebtHistory> {
  List<OrderInfo> lstOrder = [];
  List<OrderInfo> lstSelectDelivered = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }

  bool _isSelecting = false;
 


  @override
  Widget build(BuildContext context) {
    //update lstDelivered show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstWaitOrder change
    List<OrderInfo> lstDelivered = [];
    // get lstDelivered 
    for( var order in lstOrder) {
        if ((order.completedTime !=null) && order.type == "PURCHASE_ORDER"){
          lstDelivered.add(order);
        }
    }     
    //
    double widthInContainer = 90.w*0.9;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //
    return Scaffold(
      backgroundColor: Color(0xfff3f5f6),
      appBar: PreferredSize(       
        preferredSize: Size.fromHeight(70), 
        child: AppBar(
           elevation: 0,
           backgroundColor: Color(0xffe01e5a),
           leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
           ),
           centerTitle: true,
           title: Text(
              "Lịch sử nợ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),
           )
        ) 
      ),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w,height: 10),
            //textbutton xem theo tháng
            TextButton(
                onPressed: () async{
                  await showMonthPicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021), 
                    lastDate: DateTime(2023),
                    locale: Locale("en"),                    
                  ).then((DateTime? value){
                      if(value != null) {
                        DateTime fromDate = DateTime.now();
                        fromDate = value;
                        //đây là tháng đã chọn
                        final String month =  DateFormat('MM/yyyy').format(fromDate);
                        //show toast
                        Fluttertoast.showToast(
                          msg: "Bạn vừa chọn $month",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14.0
                        );
                        //build list mới từ tháng đã chọn đã chọn
                        setState(() {
                          lstSelectDelivered = lstDelivered
                            .where((element) =>
                               convertTime(element.completedTime!).contains(convertTime("$value")))
                            .toList();  
                          _isSelecting = true;   
                        });
                        print(lstSelectDelivered);       
                      } 
                  });
                }, 
                child: Text("Xem theo tháng", style: TextStyle(color: Color(0xff7b2626)),)
              ),
            SizedBox(height: 5),            
  
            //listview ô lịch sử, nếu chưa select tháng thì hiện dấu : trước.
            _isSelecting
            //listview khi select
            ?ListView.builder(
               reverse: true,
               itemCount: lstSelectDelivered.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(width: 100.w,height: 5),                     
                      //container ô lịch sử         
                      Container(
                        width: 90.w,
                        height: 80,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(width: 90.w, height: 10,),
                            //đơn hàng + thời gian hoàn thành
                            SizedBox(
                              width: widthInContainer,
                              height: 32,
                              child: Row(
                                children: [
                                  //order code
                                  SizedBox(
                                    width: widthInContainer*0.75,
                                    child: Text("Đơn hàng #${lstSelectDelivered[index].orderCode}", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                                  ),
                                  //ngày hoàn thành
                                  SizedBox(
                                    width: widthInContainer*0.25,
                                    child: Text("${convertTime(lstSelectDelivered[index].completedTime as String)}", maxLines: 1, textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c)),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height: 3,),
                            //+ giá tiền
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("+ ${lstSelectDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}đ", textAlign: TextAlign.left, style: TextStyle(color: Color(0xff7b2626), fontSize: 15, fontWeight: FontWeight.w500),),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
             )
             //listview ban đàu
            :ListView.builder(
               reverse: true,
               itemCount: lstDelivered.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(width: 100.w,height: 5),                     
                      //container ô lịch sử         
                      Container(
                        width: 90.w,
                        height: 80,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(width: 90.w, height: 10,),
                            //đơn hàng + thời gian hoàn thành
                            SizedBox(
                              width: widthInContainer,
                              height: 30,
                              child: Row(
                                children: [
                                  //order code
                                  SizedBox(
                                    width: widthInContainer*0.75,
                                    child: Text("Đơn hàng #${lstDelivered[index].orderCode}", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                                  ),
                                  //ngày hoàn thành
                                  SizedBox(
                                    width: widthInContainer*0.25,
                                    child: Text("${convertTime(lstDelivered[index].completedTime as String)}", maxLines: 1,textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c)),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height:3,),
                            //+ giá tiền
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("+ ${lstDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}đ", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(color: Color(0xff7b2626), fontSize: 15, fontWeight: FontWeight.w500),),

                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
            ),
            SizedBox(height: 20,)
          ]
        ),
      ),
    );
  }

  // Hàm convert thành ngày tháng
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  } 

}