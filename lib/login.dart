import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bkdms/HomePage.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:bkdms/Models/user.dart';




class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return LoginState();
  }
}


class LoginState extends State<Login> {

  bool checkLogin = false;
  /*void postAPI(){
    print("bắt đầu post API");
    const url= "https://jsonplaceholder.typicode.com/todos/1";
    String json = '{}'; 
    http.post(
      url,
      body: json,
    ).then((response) {
      var getResponse = response.statusCode;
      print(getResponse);
    });
  }*/

  void makePostRequest() async {
  // cài đặt tham số POST request
  print("post mới");
  String url = 'https://bkdms.herokuapp.com/api/v1/auth/login-agency';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"phone": "0987456789", "password": "chinhnguyen123", "workspace": "bkdms"}';
  // tạo POST request
  Response response = await post(url, headers: headers, body: json);
  // kiểm tra status code của kết quả response
  int statusCode = response.statusCode;
  // API này trả về id của item mới được add trong body
  String body = response.body;
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
  if (statusCode == 200) checkLogin = true;
  print(statusCode);
  }
  

  String _workSpace = "1234";
  String _phone;
  String _passWord;

  bool _obscureText = true; // con mắt để hiện mật khẩu
  var darkGrey = Color(0xff544C4C); // màu xám

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child:  
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Image.asset("assets/LogoLogin.png", scale: 1.1,),
              Text(
                "Workspace",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff1581C8),
                ),
              ),
              Container(// chứa form nhập workspace
              height: 50,
              width: 220,
              // form workspace
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorHeight: 21,
                cursorColor: Colors.black,
                style: TextStyle(fontSize: 20),
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.apartment,size: 30,),
                  fillColor: Color(0xffE2DDDD),
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff1581C8),
                      width: 1.5,
                    ),
                  ),
                ), 
                onSaved: (String inputWorkSpace){ // lưu biến workspace
                    //this._workSpace = inputWorkSpace;
                },
              ),
            ),
            SizedBox(height:10),
            SizedBox(// chứa form số điện thoại
              height: 50,
              width: 360,
              // form số điện thoại
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorHeight: 23,
                cursorColor: darkGrey,
                style: TextStyle(fontSize: 21),
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
                cursorHeight: 23,
                cursorColor: darkGrey,
                obscureText: _obscureText,
                style: TextStyle(fontSize: 21),
                decoration:  InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  ), // Icon con mắt
                  fillColor: Color(0xffE2DDDD),
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0xffE2DDDD)),
                  ),
                  hintText: "Mật khẩu",
                  hintStyle: TextStyle(
                    fontSize: 20.0, 
                    color: darkGrey,
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
                //postAPI();
                //print(_workSpace);
                makePostRequest();
                print(checkLogin);
                if (checkLogin == true) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                }
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
            
            SizedBox(height: 130,),

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
      )
      
      );  
  }
}