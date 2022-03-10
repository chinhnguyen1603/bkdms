import 'package:flutter/material.dart';
import 'package:bkdms/Components/AppBarTransparent.dart';
import './Login.dart';
class ResetPassword extends StatelessWidget {
  final _formResetPassKey = GlobalKey<FormState>();
  final userInput = TextEditingController();
  final darkGrey = Color(0xff544C4C); // màu xám
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;
    
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,""),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
        children: [
          SizedBox(height: 15,),
          Icon(
            Icons.lock_open_sharp,
            size: 110,
            color: Color(0xff254FB0),            
          ),
          Text(
            "CẤP LẠI MẬT KHẨU",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color(0xff565151),
            ),
          ),
          SizedBox(height:50),
          SizedBox(
            width: widthDevice*0.95,
            child: Text(
              "Nhập sdt của tài khoản và chúng tôi sẽ gửi tin nhắn chứa mã xác nhận",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          
          // chứa form nhập số điện thoại
          SizedBox(height: 10,),
          Form(key: _formResetPassKey, child: 
          SizedBox(
              height: 55,
              width: myWidth,
              // form số điện thoại
              child: TextFormField(
                controller: userInput,
                keyboardType: TextInputType.number,
                cursorHeight: 23,
                cursorColor: darkGrey,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Số điện thoại không được để trống';
                  }
                  return null;
                },
                decoration:  InputDecoration(
                  prefixIcon: Icon(
                    Icons.perm_phone_msg,
                    color: Colors.black,
                    size: 30,
                  ),
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
          ),
          
          //Button Gửi
          SizedBox(height: 25,),
          SizedBox(
             height: 40,
             width: 140,
             child: ElevatedButton(   
               onPressed: () {
                 //validate form user gõ xem có null không
                 if (_formResetPassKey.currentState!.validate()){
                  // Alert Dialog
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: SizedBox(child: const Text(
                        'MÃ XÁC MINH ĐÃ ĐƯỢC GỬI ĐẾN SDT CỦA BẠN. HÃY KIỂM TRA VÀ ĐĂNG NHẬP LẠI',
                        textAlign: TextAlign.center,
                      ),),
                      actions: [TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())),
                        child: Center( child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                         ),),
                        ),                      
                      ],                  
                    ),
                  );
                 };
               },
               style: ButtonStyle(
                 elevation: MaterialStateProperty.all(0),
                 backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    )
                 ),
               ),         
               child: Text(
                 "Gửi",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 22,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
            ),
 
          
        ],
      ),
      )
    );
  }
}