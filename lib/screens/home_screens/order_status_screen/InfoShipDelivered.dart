import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class InfoShipDelivered extends StatefulWidget {
  late List<dynamic> lstWayBills;
  InfoShipDelivered(this.lstWayBills);

  @override
  State<InfoShipDelivered> createState() => _InfoShipDeliveredState();
}

class _InfoShipDeliveredState extends State<InfoShipDelivered> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> lstWayBills = widget.lstWayBills;
    double myWidth = 90.w;
    //
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff7b2626),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Thông tin vận chuyển", style: TextStyle(color: Color(0xff7b2626)),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount:lstWayBills.length,              
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            //Lấy thông tin trong vận đơn
            //bên gửi
            String sendName ="", sendPhone = "", sendAddress = "";
            if(lstWayBills[index]['sendName'] != null) {
              sendName = lstWayBills[index]['sendName'];
            }
            if(lstWayBills[index]['sendPhone'] != null) {
              sendPhone = lstWayBills[index]['sendPhone'];
            } 
            if(lstWayBills[index]['sendAddress'] != null) {
              sendAddress = lstWayBills[index]['sendAddress'];
            } 
            //bên nhận                        
            String receiptName ="", receiptPhone = "", receiptAddress = "";
            if(lstWayBills[index]['receiptName'] != null) {
              receiptName = lstWayBills[index]['receiptName'];
            }
            if(lstWayBills[index]['receiptPhone'] != null) {
              receiptPhone = lstWayBills[index]['receiptPhone'];
            } 
            if(lstWayBills[index]['receiptAddress'] != null) {
              receiptAddress = lstWayBills[index]['receiptAddress'];
            }     
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
            //thông tin chi tiết
            List<Map> lstStatusBills = [];
            if(lstWayBills[index]['createTime'] != null){
              lstStatusBills.add({
                "status": "Khởi tạo vận đơn từ nhà cung cấp.",
                "time": "${convertTimeState(lstWayBills[index]['createTime'])}"
              });     
            } 
            if(lstWayBills[index]['exportTime'] != null){
              lstStatusBills.add({
                "status": "Đơn hàng đã xuất kho.",
                "time": "${convertTimeState(lstWayBills[index]['exportTime'])}"
              });     
            } 
            if(lstWayBills[index]['shippingTime'] != null){
              lstStatusBills.add({
                "status": "Đơn hàng đang được vận chuyển đến người nhận.",
                "time": "${convertTimeState(lstWayBills[index]['shippingTime'])}"
              });     
            } 
            if(lstWayBills[index]['deliveryFailedTime'] != null){
              lstStatusBills.add({
                "status": "Vận chuyển gặp sự cố.",
                "time": "${convertTimeState(lstWayBills[index]['deliveryFailedTime'])}"
              });     
            }   
            if(lstWayBills[index]['deliveredTime'] != null){
              lstStatusBills.add({
                "status": "Vận chuyển thành công đến người nhận.",
                "time": "${convertTimeState(lstWayBills[index]['deliveredTime'])}"
              });     
            }                        
            //      
            return Column(
              children: [
                SizedBox(width: 100.w, height: 30,),
                //container chứa thông tin về vận đơn
                Container(
                  width: 90.w,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xff544c4c)),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: myWidth,
                        child: Text("Mã vận đơn: ${lstWayBills[index]['receiptCode']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Color(0xff105480), fontWeight: FontWeight.w500),),
                      ),
                      SizedBox(height: 8,),
                      //bên gửi
                      SizedBox(
                        width: myWidth,
                        child: Text("Người gửi: $sendName - $sendPhone"),
                      ),
                      SizedBox(height: 3,),
                      SizedBox(
                        width: myWidth,
                        child: Text("Địa chỉ gửi: $sendAddress", maxLines: 2,),
                      ),
                      SizedBox(height: 10,),
                      //bên nhận
                      SizedBox(
                        width: myWidth,
                        child: Text("Người nhận: $receiptName - $receiptPhone",),
                      ),
                      SizedBox(height: 3,),
                      SizedBox(
                        width: myWidth,
                        child: Text("Địa chỉ nhận: $receiptAddress", maxLines: 2,),
                      ),  
                      SizedBox(height: 3,),                         
                      SizedBox(
                        width: myWidth,
                        child: Divider(thickness: 2,),
                      ),
                      SizedBox(height: 3,),                      
                      //tình trạng vận đơn
                      SizedBox(
                        width: myWidth,
                        child: Text("Tình trạng: $statusBill", style: TextStyle(fontSize: 16, color: Color(0xfff53838), fontWeight: FontWeight.w500),),
                      ),
                       //list view trạng thái
                       ListView.builder(
                         itemCount: lstStatusBills.length,              
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: myWidth*0.05,
                                      child: Icon(Icons.arrow_right_rounded, color: Color(0xff105480), size: 18,),
                                    ),
                                    //text trạng thái 
                                    SizedBox(
                                      width: myWidth*0.7,
                                      child: Text("${lstStatusBills[index]['status']}", maxLines: 2 ,style: TextStyle(color: Color(0xff40a292)),),
                                    ),
                                    //time
                                    SizedBox(
                                      child: Text("${lstStatusBills[index]['time']}",textAlign: TextAlign.center ,style: TextStyle(fontSize: 12, color: Color(0xff544c4c)),),
                                    )
                                  ], 
                                ),
                                SizedBox(
                                  width: myWidth*0.85,
                                  child: Divider(),
                                )
                              ],
                            );
                         }
                       )
                                                                                                            
                    ],
                  ),
                )

              ],
            );             
          }
        ),
      ),
      
    );
  }

  // Hàm convert thời gian ở trạng thái đơn
  String convertTimeState(String time){
    var timeConvert = DateFormat('dd-MM-yyyy \n HH:mm').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }  

}