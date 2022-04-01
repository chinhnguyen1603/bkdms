import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './HomePage.dart';
import 'package:bkdms/services/ToLogin.dart';
import './ResetPassword.dart';
import './Register.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:bkdms/models/CountBadge.dart';



class Login extends StatefulWidget {
                          
  @override
  State<StatefulWidget> createState(){
    return LoginState();
  }
}


class LoginState extends State<Login> {
  Future<Agency>? _login;

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
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị

    return  Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),) 
      : SingleChildScrollView(
      child: Consumer<Agency?>( builder: (ctxAgency, user, child) { return
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Form(
          key: _formLoginKey,
          child: Column(
          children: [
            Image.asset("assets/LogoLogin.png", scale: 1.2,),
              
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
                    return "Workspace không được để trống";
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
              width: widthDevice*0.9,
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
              width: widthDevice*0.9,
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
                   Connectivity _connect = Connectivity();
                   ConnectivityResult connectivityResult = await _connect.checkConnectivity();
                    // nếu không có mạng thì show snackbar lỗi
                    if (connectivityResult == ConnectivityResult.none) {
                      setState(() {
                        _isLoading = false;
                      });
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text('Kiểm tra kết nối mạng'),
                        action: SnackBarAction(label: 'Undo', onPressed: () {},),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    // có mạng thì post api
                    else{
                      _login = postAPI(phoneController.text,passwordController.text,workspaceController.text);
                      _login?.catchError((onError){
                         // phụ trợ xử lí String
                         String fault = onError.toString().replaceAll("{", ""); // remove {
                         String outputError = fault.replaceAll("}", ""); //remove }  
                         // Alert Dialog khi lỗi xảy ra
                         showDialog(
                           context: context, 
                           builder: (ctx1) => AlertDialog(
                               title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                               content: Text(outputError),
                               actions: [TextButton(
                                 onPressed: () => Navigator.pop(ctx1),
                                 child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                                    ),                      
                               ],                                      
                         ));
                         setState(() {
                            _isLoading = false;
                         });
                      })
                      .then((val) async {
                        user?.updateValue(val);
                        print("test thử name");
                        print(user?.name);
                        //update số lượng hàng trong giỏ để show trên icon giỏ hàng
                        await Provider.of<CartProvider>(context, listen: false).getCart(user?.token, user?.workspace, user?.id);
                        Provider.of<CountBadge>(context, listen: false).counter = Provider.of<CartProvider>(context, listen: false).lstCart.length;
                      })
                      .then((_) async => {      
                        await Provider.of<ItemProvider>(context, listen: false).fetchAndSetItem(user?.token, user?.workspace),
                        print("test kết quả lstItem"),
                        print(Provider.of<ItemProvider>(context, listen: false).lstItem),
                        setState(() {
                          _isLoading = false;
                        }),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
                      });                      
                  }  
                }
               },// onPressed
               style: ButtonStyle(
                 elevation: MaterialStateProperty.all(0),
                 backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0),)
                 )
               ),
               child: Text(
                 "Đăng nhập",
                 style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold,),
               ),
             ),
            ),
          
            //TextButton quên mật khẩu
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                }, 
                child: Text(
                "Quên mật khẩu",
                 style: TextStyle(
                   fontSize: 12,
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
      );
      })
    ));
      
  }
}