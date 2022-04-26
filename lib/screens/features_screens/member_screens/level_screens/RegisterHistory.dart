import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RegisterHistory extends StatefulWidget {
  const RegisterHistory({ Key? key }) : super(key: key);

  @override
  State<RegisterHistory> createState() => RegisterHistoryState();
}

class RegisterHistoryState extends State<RegisterHistory> {

  //Gọi Provider lịch sử tại đây
  @override
  void initState() {
    super.initState();
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
              "Lịch sử đăng kí",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),
           )
        ) 
      ),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w,height: 20),
            ListView.builder(
               reverse: true,
               itemCount: 3,              
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
                                    child: Text("Bạn đã đăng kí hạn mức", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                  ),
                                  //ngày hoàn thành
                                  SizedBox(
                                    width: widthInContainer*0.35,
                                    child: Text("20/11/2021", maxLines: 1,textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c)),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height:3,),
                            //+ giá tiền
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("• Thân thiết", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),

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