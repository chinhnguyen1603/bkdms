
import 'package:bkdms/screens/features_screens/member_screens/level_screens/RegisterHistory.dart';
import 'package:bkdms/screens/features_screens/member_screens/level_screens/RegisterLevel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:bkdms/components/AppBarTransparent.dart';

class ScreenLevel extends StatefulWidget {
  const ScreenLevel({ Key? key }) : super(key: key);

  @override
  State<ScreenLevel> createState() => _ScreenLevelState();
}

class _ScreenLevelState extends State<ScreenLevel> {
  double myWidth = 90.w;
  List <Color> lstColor = [Color(0xffdeaa23), Color(0xff7b2626), Color(0xff254fb0), Color(0xff23bb86), Color(0xfffa620c)  ]; 
  static const darkGrey = Color(0xff544c4c);

  @override
  Widget build(BuildContext context) {  
    double widthContainer = myWidth*0.9;
    //
    return Scaffold(
      appBar: AppBarTransparent(Colors.white, "Hạn mức"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 20,),
            //text Hoạt động
            SizedBox(width: myWidth, child: Text("Hoạt động", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 20,),

            //đăng kí mới
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLevel()));
              },
              child: Container(
                width: widthContainer,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(37, 79, 176, 0.3),
                      blurRadius: 25,        
                      offset: Offset(0,2), 
                    )
                  ]
                ),
                alignment: Alignment.center,
                //icon + text + tại đây
                child: SizedBox(
                  width: widthContainer,
                  height: 70,
                  child: Row(
                    children: [
                      //icon
                      SizedBox(
                        width: widthContainer*0.2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                              shape: BoxShape.circle,
                            ),   
                            child: SizedBox(height: 30,width: 30, child: Icon(Icons.edit_calendar_outlined, color: Color(0xff5677ff),), )
                        ),
                      ),                         
                      //text + mô tả 
                      SizedBox(
                        height: 60,
                        width: myWidth*0.5,
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Đăng kí mới", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 3,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Tham gia để tận hưởng ưu đãi", textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                            )
                          ],
                        ),
                      ), 
                      //icon mũi tên
                      SizedBox(
                        height: 60,
                        width: myWidth*0.2,
                        child: Icon(Icons.arrow_forward_ios,)
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            //xem lịch sử
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterHistory()));
              },
              child: Container(
                width: widthContainer,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(37, 79, 176, 0.3),
                      blurRadius: 25,        
                      offset: Offset(0,2), 
                    )
                  ]
                ),
                alignment: Alignment.center,
                //icon + text + tại đây
                child: SizedBox(
                  width: widthContainer,
                  height: 70,
                  child: Row(
                    children: [
                      //icon
                      SizedBox(
                        width: widthContainer*0.2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                              shape: BoxShape.circle,
                            ),   
                            child: SizedBox(height: 30,width: 30, child: Icon(Icons.difference_outlined, color: Color(0xff5677ff),), )
                        ),
                      ),                         
                      //text + mô tả 
                      SizedBox(
                        height: 60,
                        width: myWidth*0.5,
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Xem lịch sử", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 3,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Lịch sử đăng kí hạn mức", textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                            )
                          ],
                        ),
                      ), 
                      //icon mũi tên
                      SizedBox(
                        height: 60,
                        width: myWidth*0.2,
                        child: Icon(Icons.arrow_forward_ios,)
                      )
                    ],
                  ),
                ),
              ),
            ),
 
            SizedBox(height: 30,),
            
            //text Thông tin hạn mức
            SizedBox(width: myWidth, child: Text("Thông tin hạn mức", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,)            
          ],
        )
      ),
    );
  }


}