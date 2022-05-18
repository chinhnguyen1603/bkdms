import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Level.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';
import 'package:bkdms/services/LevelProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class RegisterLevel extends StatefulWidget {

  @override
  State<RegisterLevel> createState() => _RegisterLevelState();
}


class _RegisterLevelState extends State<RegisterLevel> {
  double myWidth = 90.w;
  static const dialogColor = Color(0xff4690FF);
  static const darkGrey = Color(0xff544c4c);
  List <Color> lstColor = [Color(0xffdeaa23), Color(0xff7b2626), Color(0xff254fb0), Color(0xff23bb86), Color(0xfffa620c)  ]; 
  //List level
  List<Level> lstLevel = [];
  //list điều kiện đăng kí
  List<dynamic> lstRegistrationConditions =[];
  String currentDebt ="";
  String revenue ="";
  String minDayJoin ="";

  @override
  void initState() {
    super.initState();
    //khởi tạo list level bằng level provider
    lstLevel = Provider.of<LevelProvider>(context, listen: false).lstLevel;
  }  

  @override
  Widget build(BuildContext context) {
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    //    
    return Scaffold(
      backgroundColor: Color(0xfffffdfd),
      appBar: AppBarTransparent(Color(0xfffffdfd),"Đăng kí"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w,height: 30,),
            //listview level
            ListView.builder(
              itemCount: lstLevel.length,              
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                //lấy list điều kiện đăng kí
                lstRegistrationConditions = lstLevel[index].registrationConditions;
                for(var indexArr = 0; indexArr < lstRegistrationConditions.length; indexArr ++){
                  //lấy nợ hiện tại 
                  if(lstRegistrationConditions[indexArr]['name'] == "CURRENT_DEBT"){
                     currentDebt = lstRegistrationConditions[indexArr]['value'];
                  }
                  //lấy doanh thu 
                  if(lstRegistrationConditions[indexArr]['name'] == "REVENUE"){
                     revenue = lstRegistrationConditions[indexArr]['value'];
                  }  
                  //lấy ngày tham gia
                  if(lstRegistrationConditions[indexArr]['name'] == "MIN_DAY_JOIN"){
                     minDayJoin = lstRegistrationConditions[indexArr]['value'];
                  }                                   
                }
                //
                return Column(
                  children: [
                    //container chứa ô đăng kí
                    Container(
                      width: myWidth,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(75, 106, 108, 114),
                            blurRadius: 4,        
                            offset: Offset(1,2), 
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(width: myWidth, height: 12,),
                          //tên hạn mức
                          SizedBox(
                            width: myWidth,
                            child: Text("${lstLevel[index].name}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: lstColor[index]),),
                          ),
                          SizedBox(
                            width: myWidth*0.9,
                            child: Divider(endIndent: 5,),
                          ),

                          //text điều kiện đăng kí
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Điều kiện đăng kí", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          ),
                          SizedBox(height: 5,),
                          
                          //các chỉ số điều kiện
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Nợ hiện tại nhỏ hơn: ${currentDebt.replaceAllMapped(reg, mathFunc)}đ", textAlign: TextAlign.left, style: TextStyle(color: darkGrey),),
                          ),  
                          SizedBox(height: 5,),                          
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Ngày tham gia lớn hơn: $minDayJoin", textAlign: TextAlign.left, style: TextStyle(color: darkGrey),),
                          ),   
                          SizedBox(height: 5,),
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Doanh số đã đạt lớn hơn: ${revenue.replaceAllMapped(reg, mathFunc)}đ", textAlign: TextAlign.left, style: TextStyle(color: darkGrey,),),
                          ),  
                          SizedBox(
                            width: myWidth*0.9,
                            child: Divider(),
                          ),
                          SizedBox(height: 5,),
                          
                          //button chọn hạn mức
                          SizedBox(
                            width: myWidth*0.4,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: (){
                                //dialog xác nhận
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  desc: "Xác nhận đăng kí hạn mức này?",
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
                                              FutureProgressDialog(registerThisLevel(lstLevel[index].id)),
                                        );
                                        //ẩn pop-up
                                        Navigator.pop(context);
                                      },
                                      color: dialogColor,
                                    )
                                  ],).show();
                              }, 
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                              ),
                              child: Text("Chọn hạn mức")
                            ),

                          )                                                                           
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],

                );             
              }
            )
          ],
        ),
      ),      
    );
  }

  // hàm đăng kí hạn mức
  Future registerThisLevel( String levelId) {
    return Future(() async {
    //gọi provide order delete sau đó get lại
    Agency user = Provider.of<Agency>(context, listen: false);
    await Provider.of<LevelProvider>(context, listen: false).registerLevel(user.token, user.workspace, user.id, levelId)
     .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi register future dialog");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$onError"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx1),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                    ),                      
                  ],
              )
          );            
      }).then((value) {
          //aleart dialog thành công
          Alert(
            context: context,
            type: AlertType.success,
            style: AlertStyle(
              descTextAlign: TextAlign.start,
              descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xff544c4c)),
            ),
            desc: "Đăng kí thành công",                
            buttons: [ 
              DialogButton(
                child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(0)), (Route<dynamic> route) => false),
                width: 100,
              )
            ],
          ).show();        
      });  
    });
  }   

}