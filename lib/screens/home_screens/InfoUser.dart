import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/screens/home_screens/Login.dart';
import 'InfoApp.dart';
import 'dart:ui';
import 'package:bkdms/models/Agency.dart';
import 'package:provider/provider.dart';




class InfoUser extends StatelessWidget {
  static const darkGrey = Color(0xff544C4C); // màu xám icon button
  static const mintGrey = Color(0xffFAFAFA); //màu xám background
  static const beautyBlue = Color(0xff2960A0); // màu xanh dương
  static const line = Color(0xffC4C4C4); // màu xám kẻ line

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBarGrey("Hồ sơ"),
      body: SingleChildScrollView(
        child: Consumer<Agency?>( builder: (ctx, user, child) { 
        
        //biến provider
        String? phone =user?.phone;
        String? storeName = user?.name;
        String? userName = user?.nameOwn;
        String? street = user?.extraInfoOfAddress;
        String? ward = user?.ward;
        String? district = user?.district;
        String? province = user?.province;

        //xử lý datejoin
        String? dateJoin = user?.dateJoin;
        String dateJoin1 = "$dateJoin";
        List<String> splitDate = dateJoin1.split('-');
        String dateOutput = splitDate[2] + "-" + splitDate[1] + "-" + splitDate[0];


        return Column(
          children: [
            // Container chứa tài khoản
            Container(
             margin: EdgeInsets.only(top: 15),
               child: Column(
                 children:[ 
                   SizedBox(
                    width: myWidth,          
                    child: Text(
                       "Tài khoản",
                       textAlign: TextAlign.left,
                       style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600, color: beautyBlue,) 
                    ),
                   ),
                   SizedBox(height: 5,),
                   //Container chứa điện thoại
                   Container(
                     height: 40,
                     width: myWidth,
                     color: mintGrey,
                     child: Row(  
                      children: [
                        SizedBox(width:5,),
                        SizedBox(
                          width: myWidth*0.3,
                          child: Text("Số điện thoại"),
                        ),
                        SizedBox(width:myWidth*0.15),
                        Text(                       
                          "$phone",
                        ),
                     ],),
                   ),
                   //Container chứa mật khẩu
                   Container(
                     height: 40,
                     width: myWidth,
                     child: Row(children: [
                        SizedBox(width:5,),
                        SizedBox(
                          width: myWidth*0.3,
                          child: Text("Mật khẩu"),
                        ),
                        SizedBox(
                          width:myWidth*0.15,
                        ),
                        Text(
                          "*********",
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: myWidth*0.15,),
                        SizedBox( 
                         width: myWidth*0.2,          
                         child: IconButton(
                          onPressed: null, 
                          alignment: Alignment.topRight,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          )    
                         ),
                        )
                     ],),
                   )
                 ]
               )
             ),          
            
            //Divider 
            Divider( color: line, thickness: 1,),
            
            // Container chứa cá nhân
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
               children: [
                 SizedBox(
                  width: myWidth,
                  child:Text(
                    "Cá nhân",
                    textAlign: TextAlign.left,
                    style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600, color: beautyBlue,) 
                  ),
                 ),
                 SizedBox(height: 5,),
                 //Container tên cửa hàng
                 Container(
                  height: 50,
                  width: myWidth,
                  color: mintGrey,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                       width: myWidth*0.3,
                       child: Text("Tên cửa hàng"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       child: 
                        Text(                       
                           "Cửa hàng $storeName",
                        ),
                       )
                      ]
                    ),
                  ), 
                  // Container đại diện
                 Container(
                  height: 50,
                  width: myWidth,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                      width:myWidth*0.3,
                       child:              
                        Text("Đại diện"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       child: 
                        Text(                       
                           "$userName"
                        ),
                       )
                      ]
                    ),
                  ), 
                  // Container địa chỉ
                 Container(
                  height: 50,
                  width: myWidth,
                  color: mintGrey,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                      width:myWidth*0.3,
                       child:              
                        Text("Địa chỉ"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       height: 50,
                       child: Column(children: [
                        SizedBox(height: 10,),
                        Text(                       
                          "$street," + " $ward," +" $district," + " $province",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12),
                        ),
                       ],)
                      )
                     ],
                    ),
                  ),     
                  // COntainer Hạng mức
                 Container(
                  height: 50,
                  width: myWidth,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                      width:myWidth*0.3,
                       child:              
                        Text("Hạng mức"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       child: 
                        Text(                       
                           "Cơ bản"
                        ),
                       )
                    ]
                   )
                  ),
                  // COntainer điểm thưởng
                 Container(
                  height: 50,
                  width: myWidth,
                  color: mintGrey,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                      width:myWidth*0.3,
                       child:              
                        Text("Điểm thưởng"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       child: 
                        Text(                       
                           "200"
                        ),
                       )
                      ]
                    ),
                  ), 
                 //Container Ngày gia nhập
                 Container(
                  height: 50,
                  width: myWidth,
                  child: Row(  
                    children: [
                      SizedBox(width:5,),
                      SizedBox(
                       width: myWidth*0.3,
                       child: Text("Ngày gia nhập"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       child: 
                        Text(                       
                           "$dateOutput",
                        ),
                       )
                    ]
                   )
                  ),
  
                      ]
                    ),
                  ),                            
            
            //Divider  
            Divider( color: line, thickness: 1,),
            
            //Container chứa thông tin ứng dụng
            GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoApp()));
            } ,
            child:
            Container(
              height: 40,
              width: widthDevice,
              child: Center(
                child: Row(
                children: [
                  SizedBox(
                    width: widthDevice*0.25,
                    child: Icon(
                      Icons.info_outline,
                      color: beautyBlue,
                    ),
                  ),
                  SizedBox(
                    width: widthDevice*0.5,
                    child: Text(
                      "Thông tin ứng dụng",
                       textAlign: TextAlign.center,
                       style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600, color: beautyBlue,) 
                       ), 
                  ),
                ],
              ),),
            ),
            ),

            //Divider
            Divider(
              color: line,
              thickness: 1,
            ),
            
            //Container chứa đăng xuất
            GestureDetector(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            } ,
            child:
            Container(
              height: 40,
              width: widthDevice,
              child: Center(
                child: Row(
                children: [
                  SizedBox(
                    width: widthDevice*0.25,
                    child: Icon(
                      Icons.input,
                      color: beautyBlue,
                    ),
                  ),
                  SizedBox(
                    width: widthDevice*0.5,
                    child: Text(
                      "Đăng xuất",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w600,
                         color: beautyBlue,
                       ) 
                    ), 
                  ),
                ],
              ),),
            ),
            ),

            // divider cuối cùng
            Divider(
              color: line,
              thickness: 1,
            ),
          ],
        );
      })
    ));
  }
}