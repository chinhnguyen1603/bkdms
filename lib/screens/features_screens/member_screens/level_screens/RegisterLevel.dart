import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class RegisterLevel extends StatefulWidget {

  @override
  State<RegisterLevel> createState() => _RegisterLevelState();
}


class _RegisterLevelState extends State<RegisterLevel> {
  double myWidth = 90.w;
  static const darkGrey = Color(0xff544c4c);
  List <Color> lstColor = [Color(0xffdeaa23), Color(0xff7b2626), Color(0xff254fb0), Color(0xff23bb86), Color(0xfffa620c)  ]; 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffdfd),
      appBar: AppBarTransparent(Color(0xfffffdfd),"Đăng kí"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w,height: 40,),
            ListView.builder(
              reverse: true,
              itemCount: 3,              
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
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
                            child: Text("Cơ bản", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
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
                            child: Text("Nợ hiện tại nhỏ hơn:", textAlign: TextAlign.left, style: TextStyle(color: darkGrey),),
                          ),  
                          SizedBox(height: 5,),                          
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Ngày tham gia lớn hơn:", textAlign: TextAlign.left, style: TextStyle(color: darkGrey),),
                          ),   
                          SizedBox(height: 5,),
                          SizedBox(
                            width: myWidth*0.9,
                            child: Text("Doanh số đã đạt lớn hơn:", textAlign: TextAlign.left, style: TextStyle(color: darkGrey,),),
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
                      height: 20,
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
}