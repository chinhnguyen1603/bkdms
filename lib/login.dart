import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bkdms/HomePage.dart';

class Login extends StatelessWidget {

  var darkGrey = Color(0xff544C4C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Image.asset("assets/LogoLogin.png", scale: 1.1,),

            SizedBox(// chứa form số điện thoại
              height: 50,
              width: 360,
              // form số điện thoại
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorHeight: 22,
                cursorColor: darkGrey,
                style: TextStyle(fontSize: 20),
                decoration:  InputDecoration(
                  fillColor: Color(0xffE2DDDD),
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0xffE2DDDD)),
                  ),
                  hintText: "SDT",
                  hintStyle: TextStyle(fontSize: 20.0, color: darkGrey),
                ), 
                
              ),
            ),

            SizedBox(height: 10),
            // chứa form mật khẩu
            SizedBox(
              height: 50,
              width: 360,
              // form mật khẩu
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 22,
                cursorColor: darkGrey,
                style: TextStyle(fontSize: 20),
                decoration:  InputDecoration(
                  fillColor: Color(0xffE2DDDD),
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0xffE2DDDD)),
                  ),
                  hintText: "Mật khẩu",
                  hintStyle: TextStyle(fontSize: 20.0, color: darkGrey
            
                  ),
                ), 
                
              ),
            ),

            SizedBox(height: 40,),

            // button đăng nhập
            SizedBox(
             height: 45,
             width: 240,
             child: ElevatedButton(    
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
               },
               style: ButtonStyle(
                 backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    )
                 )
               ),
               child: Text(
                 "Đăng nhập",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 23,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
            ),
          
            //TextButton quên mật khẩu
            SizedBox(
              height: 32,
              child: TextButton(
                onPressed: (){}, 
                child: Text(
                "Quên mật khẩu",
                 style: TextStyle(
                   fontSize: 14,
                 ),
                ),
              )
            ),
            
            SizedBox(height: 180,),

            // Text Button đăng kí đại lý mới
            TextButton(
              onPressed: (){}, 
              child: Text(
                "Đăng kí đại lý mới?",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff254FB0),
                  decoration: TextDecoration.underline,
                ),
              )
            ),
          ]
        ),
      )
    );
  }
}