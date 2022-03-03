import 'dart:ui';
import 'package:bkdms/HomePage/Login.dart';
import 'package:bkdms/Components/AppBarGrey.dart';
import 'package:flutter/material.dart';
class Register extends StatelessWidget {
  static const darkBlue = Color(0xff2033e0); 

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGrey("Đăng kí đại lý"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text giới thiệu thông tin
            Container(
              margin: EdgeInsets.only(top: 10),
              width: widthDevice,
              child: Row(children: [
                SizedBox(
                  width: widthDevice*0.15,
                  child: Icon(
                     Icons.lightbulb_outline,
                     color: Color(0xffe0a96d),
                     size: 30,
                  )
                ),          
                SizedBox(
                  width: widthDevice*0.7,
                  child: Text(
                     "Gửi thông tin cho chúng tôi để được hưởng các ưu đãi hấp dẫn trong thời gian sớm nhất",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 14,
                       fontFamily: "SegoeScript",
                       color: Color(0xff201e20)
                     ),
                  )
                ),                
              ],),

            ),
            
            //Form để người dùng nhập
             
            //Tên cửa hàng
            SizedBox(height: 10,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Tên cửa hàng",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Tên cửa hàng
              height: 45,
              width: myWidth,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  //fillColor: Color(0xffE2DDDD),
                  //filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                
              ),
            ),
     
            //Mã số thuế
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Mã số thuế",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Mã số thuế
              height: 45,
              width: myWidth,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                
              ),
            ),

            //Địa chỉ
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Địa chỉ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Địa chỉ
              height: 45,
              width: myWidth,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                
              ),
            ),

            //Người đại diện
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Người đại diện",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Người đại diện
              height: 45,
              width: myWidth,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                
              ),
            ),

            //Số điện thoại/email
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "SDT/Email",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Số điện thoại/email
              height: 45,
              width: myWidth,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                
              ),
            ),
     
            //Button gửi
            SizedBox(height: 20,),
            SizedBox(
              width: widthDevice*0.3,
              height: 40,
              child: ElevatedButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text(
                        'YÊU CẦU ĐĂNG KÍ CỦA BẠN ĐÃ ĐƯỢC TIẾP NHẬN. CHÚNG TÔI SẼ PHẢN HỒI TRONG THỜI GIAN SỚM NHẤT',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w300,
                        ),
                      ),
                      actions: [TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())),
                        child: const Text(
                            'OK',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),                      
                      ],                  
                    ),
                  ),
          //showDialog
                child:Text(
                  "Gửi",
                  style: TextStyle(
                    fontSize:22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],  
        ),
      ),
    );
  }
}