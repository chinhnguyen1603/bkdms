

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bkdms/HomePage/HomePage.dart';
import 'package:bkdms/Models/User.dart';
import 'package:bkdms/Api/ToLogin.dart';
import 'package:bkdms/HomePage/ResetPassword.dart';
//import 'package:http/http.dart';
//import 'dart:convert';
import 'package:bkdms/HomePage/Register.dart';




class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return LoginState();
  }
}


class LoginState extends State<Login> {
  Future<Agency>? _user;

  bool _obscureText = true; // con mắt để hiện mật khẩu
  var darkGrey = Color(0xff544C4C); // màu xám
  bool _isLoading = false;

  final _formLoginKey = GlobalKey<FormState>();
  final workspaceController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  void dispose(){
     workspaceController.dispose();
     phoneController.dispose();
     passwordController.dispose();
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
      child:  
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Form(
          key: _formLoginKey,
          child: Column(
          children: [
            Image.asset("assets/LogoLogin.png", scale: 1.15,),
              
            //Form workspace
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
                controller: workspaceController,
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                cursorColor: Colors.black,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Workspace không được để trống';
                  }
                  return null;
                },                
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.apartment,size: 30,),
                ),
                 
              ),
            ),
 
            SizedBox(height:10),
            // chứa form số điện thoại
            SizedBox(
              height: 60,
              width: 360,
              // form số điện thoại
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                cursorHeight: 23,
                cursorColor: darkGrey,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 21),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Số điện thoại không được để trống';
                  }
                  return null;
                },
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
              height: 60,
              width: 360,
              // form mật khẩu
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                cursorHeight: 23,
                cursorColor: darkGrey,
                obscureText: _obscureText,
                style: TextStyle(fontSize: 21),
                textAlignVertical: TextAlignVertical.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mật khẩu không được để trống';
                  }
                  return null;
                },                
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

            SizedBox(height: 30,),
            // button đăng nhập
            SizedBox(
             height: 45,
             width: 240,
             child: ElevatedButton(    
               onPressed: () async{
                 //validate form user gõ xem có null không
                 if (_formLoginKey.currentState!.validate()){
                   //form không null, bắt đầu loading
                   setState(() {
                     _isLoading = true;
                   });
                   // Post thông tin đăng nhập
                   _user = postAPI(phoneController.text,"\$2b\$10\$1RfFJ1yk8a4yeQAdqFff8.RDcT9557n3/SUw8b4ZZxp3tu/oOJKaG",workspaceController.text);
                   _user?.catchError((onError){
                      showDialog(
                        context: context, 
                        builder: (ctx) => AlertDialog(
                          title: Text("Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                          content: Text(onError.toString()),
                          actions: [TextButton(
                             onPressed: () => Navigator.pop(ctx),
                             child: Center (child: const Text(
                               'OK',
                               style: TextStyle(
                               decoration: TextDecoration.underline,
                               ),
                             ),)
                           ),                      
                          ],                                      
                        ));
                      setState(() {
                        _isLoading = false;
                      });
                   })
                   .then((val) {
                      setState(() {
                        _isLoading = false;
                      });
                      print(val.province);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                   });
                }
                // Post thông tin đăng nhập
               },
               style: ButtonStyle(
                 elevation: MaterialStateProperty.all(0),
                 backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
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
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                }, 
                child: Text(
                "Quên mật khẩu",
                 style: TextStyle(
                   fontSize: 14,
                 ),
                ),
              )
            ),
            
            SizedBox(height: 140,),

            // Text Button đăng kí đại lý mới
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              }, 
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
      )
      );  
  }
}