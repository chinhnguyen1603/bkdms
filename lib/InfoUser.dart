
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:bkdms/Api/ToLogin.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:ui';

class InfoUser  extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return InfoUserState();
  }
}


class InfoUserState extends State<InfoUser> {
  static const darkGrey = Color(0xff544C4C); // màu xám icon button
  static const mintGrey = Color(0xffFAFAFA); //màu xám background
  static const beautyBlue = Color(0xff2960A0); // màu xanh dương
  static const line = Color(0xffC4C4C4); // màu xám kẻ line
  // set responsive


  String nameOwn = " ";
  Map<String, dynamic> body;
  
  /*void makePostRequest() async {
  // cài đặt tham số POST request
     print("bắt đầu post API");
     String url = 'https://bkdms.herokuapp.com/api/v1/auth/login-agency';
     Map<String, String> headers = {"Content-type": "application/json"};
     String json = '{"phone": "0987456789", "password": "chinhnguyen123", "workspace": "bkdms"}';
     // tạo POST request
     Response response = await post(url, headers: headers, body: json);
     // kiểm tra status code của kết quả response
     int statusCode = response.statusCode;
     // API này trả về id của item mới được add trong body
     Map<String, dynamic> bodyRes = jsonDecode(response.body);
     print(bodyRes['data']['user']['name']+ bodyRes['status']);
     setState(() {
        nameOwn = bodyRes['data']['user']['nameOwn'];
     });
     print(nameOwn);
  }*/



  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
            Icons.arrow_back_ios,
            color: darkGrey,
        ),
        centerTitle: true,
        title: const Text(
            "Hồ sơ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: darkGrey,
            ),
          ),
      ),
      body: SingleChildScrollView( 
        child: Column(
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
                       style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                       color: beautyBlue,
                       ) 
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
                          width:myWidth*0.3,
                          child:              
                          Text("Số điện thoại"),
                        ),
                        SizedBox(width:myWidth*0.15),
                        Text(                       
                          "0987456789",
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
                          width:myWidth*0.3,
                          child:              
                          Text("Mật khẩu"),
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
            Divider(
              color: line,
              thickness: 1,
            ),
            
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
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: beautyBlue,
                    ) 
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
                      width:myWidth*0.3,
                       child:              
                        Text("Tên cửa hàng"),
                      ),
                      SizedBox(width:myWidth*0.15),
                      SizedBox(
                       width: myWidth*0.5,
                       height: 50,
                       child: Column(children: [
                        SizedBox(height: 10,),
                        Text(                       
                          "Cửa hàng linh kiện điện tử Trung Việt",
                          textAlign: TextAlign.left
                        ),
                       ],)
                      )
                     ],
                    ),
                  ),   
                  // COntainer đại diện
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
                           "Nguyễn Văn Việt"
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
                          "Cửa hàng linh kiện điện tử Trung Việt",
                          textAlign: TextAlign.left
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
                  // COntainer đại diện
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
                      ]
                    ),
                  ),                            
            
            //Divider  
            Divider(
              color: line,
              thickness: 1,
            ),
            
            //Container chứa thông tin ứng dụng
            Container(
              height: 40,
              width: myWidth,
              child: Row(
                children: [
                  IconButton(
                    onPressed: null, 
                    icon: Icon(
                     Icons.info_outline,
                     color: beautyBlue,
                    )),
                  SizedBox(width: myWidth*0.11),
                  TextButton(
                    onPressed: null, 
                    child: Text(
                      "Thông tin ứng dụng",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                       color: beautyBlue,
                       ) 
                    ), 
                  ),
                ],
              ),
            ),

            //Divider
            Divider(
              color: line,
              thickness: 1,
            ),
            
            //Container chứa đăng xuất
            Container(
              height: 40,
              width: myWidth,
              child: Row(
                children: [
                  IconButton(
                    onPressed: null, 
                    icon: Icon(
                     Icons.input,
                     color: beautyBlue,
                    )),
                  SizedBox(width: myWidth*0.21),
                  TextButton(
                    onPressed: null, 
                    child: Text(
                      "Đăng xuất",
                       textAlign: TextAlign.right,
                       style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                       color: beautyBlue,
                       ) 
                    ), 
                  ),
                ],
              ),
            ),
            
            // divider cuối cùng
            Divider(
              color: line,
              thickness: 1,
            ),
          ],
        ),
      )
    );
  }
}