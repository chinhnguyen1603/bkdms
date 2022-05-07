import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bkdms/services/ToLogin.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'ResetPassword.dart';
import 'Register.dart';
import 'HomePage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class Login extends StatefulWidget {
                          
  @override
  State<StatefulWidget> createState(){
    return _LoginState();
  }
}


class _LoginState extends State<Login> {
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

    return  WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                width: 90.w,
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
                width: 90.w,
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
                           Alert(
                             context: context,
                             type: AlertType.error,
                             style: AlertStyle(
                               titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                               descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: darkGrey),
                             ),
                             title: "Oops! Có lỗi xảy ra",
                             desc: outputError,
                             buttons: [ 
                               DialogButton(
                                child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                onPressed: () => Navigator.pop(context),
                                width: 100,
                               )
                             ],
                           ).show();
                           setState(() {
                              _isLoading = false;
                           });
                        })
                        .then((val) async {
                          user?.updateValue(val);
                          print("test thử name");
                          print(user?.name);
                        })
                        .then((_) async => {   
                          // get Item trong HomePage    
                          await Provider.of<ItemProvider>(context, listen: false).fetchAndSetItem(user?.token, user?.workspace)
                            .catchError((onError){
                              // phụ trợ xử lí String
                              String fault = onError.toString().replaceAll("{", ""); // remove {
                              String outputError = fault.replaceAll("}", ""); //remove }  
                              // Alert Dialog khi lỗi xảy ra
                              Alert(
                                context: context,
                                type: AlertType.error,
                                style: AlertStyle(
                                  titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                  descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: darkGrey),
                                ),
                                title: "Oops! Có lỗi xảy ra",
                                desc: outputError,
                                buttons: [ 
                                  DialogButton(
                                    child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                    onPressed: () => Navigator.pop(context),
                                    width: 100,
                                  )
                                ],
                              ).show();
                              setState(() {
                                _isLoading = false;
                              });
                            }),
                          print("test kết quả lstItem"),
                          print(Provider.of<ItemProvider>(context, listen: false).lstItem), 
                          setState(() {
                            _isLoading = false;
                          }),
                          //push
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0))), //(Route<dynamic> route) => false),
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
                  //đưa về định dạng này để so sánh,
                  String timeAPI1 = "2022-04-13";
                  //nếu d2 nhỏ hơn d1 thì trả về true. Lấy mốc trước mốc phải trả 5 ngày để so
                  var d1 = DateTime.now().toLocal();     
                  var d2 =  DateTime.parse(timeAPI1).add(Duration(days: 30)).subtract(Duration(days: 5));
                  var d3 =  DateTime.parse(timeAPI1).add(Duration(days: 31));
                  print(d2);    
                  // && công nợ > 0
                  if(d2.compareTo(d1) < 0){
                    print('true');
                    if(d3.compareTo(d1) < 0){

                    } else{
                       showNotification(convertPeriodTime(timeAPI1, 30));
                    }
                  } else{
                    print('false');
                  }
                  //showNotification();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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
      )),
    );
      
  }

  void showNotification(String date) {

    flutterLocalNotificationsPlugin.show(
        0,
        "Nhắc thanh toán công nợ",
        "Ngày $date là hạn đóng công nợ, bạn hãy vào BKDMS để thanh toán ngay nhé",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, 
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')
        )
    );
  }

  // Hàm show UI mốc phải trả nợ
  String convertPeriodTime(String inputTime, int inputMaxDebtPeriod){
    var debtStartTime = DateTime.parse(inputTime).toLocal();  
    var endTime = debtStartTime.add( Duration(days: inputMaxDebtPeriod));
    //mốc nợ sau cùng
    var timeConvert = DateFormat('dd/MM').format(endTime);
    return timeConvert;
  }
}