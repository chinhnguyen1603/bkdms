import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/ToChangePassword.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePassword extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}


class ChangePasswordState extends State<ChangePassword>{
  static const darkBlue = Color(0xff2033e0); 
  bool _obscureText = true;
  bool _obscureTextNewPass = true;
  bool _isLoading = false;

  final _formChangePasswordKey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final rePassword = TextEditingController();
  var rePasswordToCheck;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGrey("Đổi mật khẩu"),
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),) 
      : SingleChildScrollView(child: Center( child: Form( 
        key: _formChangePasswordKey, 
        child: Column(
          children: [
           //Form để người dùng nhập
            
            //Mật khẩu hiện tại
            SizedBox(height: 20,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Mật khẩu hiện tại",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form mật khẩu hiện tại
              height: 45,
              width: myWidth,
              child: TextFormField(
                controller: oldPassword,
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                obscureText: _obscureText,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa điền vào ô này';
                  }
                  return null;
                },          
              ),
            ),
     
            //Mật khẩu mới
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Mật khẩu mới",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Mật khẩu mới
              height: 45,
              width: myWidth,
              child: TextFormField(
                controller: newPassword,
                keyboardType: TextInputType.text,
                obscureText: _obscureTextNewPass,
                cursorHeight: 24,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  //vẽ viền
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                  //tap vào icon con mắt
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureTextNewPass = !_obscureTextNewPass;
                      });
                    },
                    child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  ), 
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa điền vào ô này';
                  }
                  return null;
                }, 
              ),
            ),

            //Nhập lại mật khẩu mới
            SizedBox(height: 15,),
            SizedBox(
              width: myWidth,
              child: Text(
                "Nhập lại mật khẩu mới",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(// Form Nhập lại mật khẩu mới
              height: 45,
              width: myWidth,
              child: TextFormField(
                controller: rePassword,
                keyboardType: TextInputType.text,
                cursorHeight: 24,
                obscureText: _obscureText,
                style: TextStyle(fontSize: 16),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: darkBlue),
                  ),
                ), 
                validator: (value) {
                  rePasswordToCheck = value;
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa điền vào ô này';
                  }
                  if (value != newPassword.text ){ // check nhập lại mật khẩu có khớp không
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text('Nhập lại mật khẩu mới chưa khớp'),
                        action: SnackBarAction(label: 'Undo', onPressed: () {},),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  return null;
                },  
              ),
            ),

   
            //Button gửi
            SizedBox(height: 20,),
            SizedBox(
              width: widthDevice*0.3,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Agency? user = Provider.of<Agency>(context,listen: false);
                  // check các form có null không
                  if (_formChangePasswordKey.currentState!.validate()){
                    // check nhập lại mật khẩu có khớp không
                    if (rePasswordToCheck != newPassword.text ){ 
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text('Nhập lại mật khẩu mới chưa khớp'),
                        action: SnackBarAction(label: 'Undo', onPressed: () {},),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                      // chuyển trạng thái thành vòng xoay
                      setState(() {
                        _isLoading = true;
                      });  
                      //bắt đầu POST đổi mật khẩu
                      postNewPassword(user.token, user.workspace, user.id, oldPassword.text, newPassword.text)
                      .catchError((onError){
                         // phụ trợ xử lí String
                         String fault = onError.toString().replaceAll("{", ""); // remove {
                         String outputError = fault.replaceAll("}", ""); //remove }  
                         //show dialog nếu lỗi
                         showDialog(
                           context: context, 
                           builder: (ctx1) => AlertDialog(
                           title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                           content: Text(outputError),
                           actions: [TextButton(
                              onPressed: () => Navigator.pop(ctx1),
                              child: Center (child: const Text(
                                'OK',
                                 style: TextStyle(decoration: TextDecoration.underline,),
                              ),)
                              ),                      
                             ],                                      
                         ));
                         setState(() {
                           _isLoading = false;
                         });                           
                      })
                      .then((value) {
                         setState(() {
                           _isLoading = false;
                         });
                         //aleart dialog thành công
                         Alert(
                           context: context,
                           type: AlertType.success,
                           style: AlertStyle(
                             descTextAlign: TextAlign.start,
                             descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xff544c4c)),
                           ),
                           desc: "Mật khẩu đã được đổi thành công",                
                           buttons: [ 
                             DialogButton(
                              child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0))),
                              width: 100,
                             )
                           ],
                         ).show();
                       });           
                  
                    }
                  }
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0),)
                  )
                ),    
                child:Text(
                  "Xác nhận",
                  style: TextStyle(fontSize:18, fontWeight: FontWeight.w700,),
                ),
              ),
            )
          ],  
        ),
      ),
    )
    )
   );
  }
}