import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:bkdms/services/LevelProvider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Level.dart';

class RegisterHistory extends StatefulWidget {
  const RegisterHistory({ Key? key }) : super(key: key);

  @override
  State<RegisterHistory> createState() => _RegisterHistoryState();
}

class _RegisterHistoryState extends State<RegisterHistory> {
 
  List<HistoryRegister> lstHistoryRegister = []; 

  //Gọi Provider lịch sử tại đây
  @override
  void initState() {
    super.initState();
    lstHistoryRegister = Provider.of<LevelProvider>(context, listen: false).lstHistoryRegister;
  }

  @override
  Widget build(BuildContext context) {
    double widthInContainer = 90.w*0.9;
    String cancelTime ="";
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
               itemCount: lstHistoryRegister.length,              
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                 //xử lý lấy cancelTime nếu không null
                 if(lstHistoryRegister[index].cancelTime != null) {
                   cancelTime = convertTime(lstHistoryRegister[index].cancelTime as String);
                 }
                 //lấy tình trạng của hạn mức (đạt hay chưa đạt)
                 String status = "chưa đạt điều kiện nhận thưởng";
                 if(lstHistoryRegister[index].isQualified == true) {
                   status = "đạt điều kiện nhận thưởng";
                 }
                 //
                  return Column(
                    children: [
                      SizedBox(width: 100.w,height: 5),                     
                      //container ô lịch sử         
                      Container(
                        width: 90.w,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(width: 90.w, height: 10,),
                            //text bạn đã đăng kí + tên hạn mức
                            SizedBox(
                              width: widthInContainer,
                              height: 30,
                              child: Row(
                                children: [
                                  //Text
                                  SizedBox(
                                    width: widthInContainer*0.65,
                                    child: Text("Bạn đã đăng kí hạn mức", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                  ),
                                  //tên hạn mức
                                  SizedBox(
                                    width: widthInContainer*0.35,
                                    child: Text("• ${lstHistoryRegister[index].levelName}", maxLines: 1,textAlign: TextAlign.right, style: TextStyle( color: Color(0xff544c4c), fontWeight: FontWeight.w700),),
                                  )                                  
                                ],
                              ),
                            ),
                            SizedBox(height:3,),
                            //ngày đăng kí
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("Ngày đăng kí: ${convertTime(lstHistoryRegister[index].createTime)}", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                            ),
                            SizedBox(height:3,),
                            //ngày hết hạn
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("Ngày hết hạn: ${convertTime(lstHistoryRegister[index].expireTime)}", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                             ),
                            SizedBox(height:3,), 
                            //ngày hủy đơn
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("Ngày hủy: $cancelTime", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                            ),
                            SizedBox(height:3,),   
                            //tình trạng đăng kí
                            SizedBox(
                              width: widthInContainer,
                              height: 20,
                              child: Text("Tình trạng: $status", maxLines: 1,textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                            ),
                            SizedBox(height:3,), 
                            //button kiểm tra, nếu chưa đạt thì hiện
                            lstHistoryRegister[index].isQualified
                            ?Text("")
                            :SizedBox(
                              width: widthInContainer*0.4,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async { 
                                  //show dialog chờ check level
                                  await showDialog (
                                    context: context,
                                    builder: (context) =>
                                      FutureProgressDialog(checkThisHistory(lstHistoryRegister[index].levelId, lstHistoryRegister[index].id)),
                                  );                         
                                }, 
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                              ),
                              child: Text("Kiểm tra")
                            ),
                          ),                                                                        
                          SizedBox(height: 12,)                                                                                  
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

  // hàm kiểm tra level
  Future checkThisHistory( String levelId, String historyId) {
    return Future(() async {
      //gọi provide order delete sau đó get lại
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<LevelProvider>(context, listen: false).checkLevel(user.token, user.workspace, user.id, levelId, historyId)
        .catchError((onError) async {
          // phụ trợ xử lí String
          String fault = onError.toString().replaceAll("{", ""); // remove {
          String outputError = fault.replaceAll("}", ""); //remove }  
          // Alert Dialog 
          await showDialog(
              context: context, 
              builder: (ctx) => AlertDialog(
                  title: Text("Thông báo", style: TextStyle(fontSize: 24),),
                  content: Text("$outputError"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                    ),                      
                  ],
              )
          );            
        }).then((value) async{
        });  
    });
  }   


}