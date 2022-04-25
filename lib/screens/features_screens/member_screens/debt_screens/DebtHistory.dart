import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DebtHistory extends StatefulWidget {
  const DebtHistory({ Key? key }) : super(key: key);

  @override
  State<DebtHistory> createState() => DebtHistoryState();
}

class DebtHistoryState extends State<DebtHistory> {

  List<String> lstDate = [];
  List<String> lstSelectMonth = [];
  List<String> getTimeApi = ["2021-12-15T08:34:12.015Z", "2022-01-20T17:49:55.441Z", "2022-04-17T17:53:32.843Z", "2022-04-20T17:50:42.782Z"]; 
  bool _isSelecting = false;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for( var time in getTimeApi) {
       this.lstDate.add(convertTime(time));
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthInContainer = 90.w*0.9;
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
                          lstSelectMonth = lstDate
                            .where((element) =>
                               element.contains("$month"))
                            .toList();  
                          _isSelecting = true;   
                        });
                        print(lstSelectMonth);       
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
               itemCount: lstSelectMonth.length,              
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
                                    width: widthInContainer*0.65,
                                    child: Text("Đơn hàng #162291828", maxLines: 1, textAlign: TextAlign.left, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                  ),
                                  //ngày hoàn thành
                                  SizedBox(
                                    width: widthInContainer*0.35,
                                    child: Text("${lstSelectMonth[index]}", maxLines: 1, textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c)),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height: 3,),
                            //+ giá tiền
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("+ 50.000.000đ", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),

                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
               }
             )
             //listview khi select
            :ListView.builder(
               reverse: true,
               itemCount: lstDate.length,              
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
                                    width: widthInContainer*0.65,
                                    child: Text("Đơn hàng #162291828", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                  ),
                                  //ngày hoàn thành
                                  SizedBox(
                                    width: widthInContainer*0.35,
                                    child: Text("${lstDate[index]}", maxLines: 1,textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c)),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height:3,),
                            //+ giá tiền
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("+ 50.000.000đ", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),

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