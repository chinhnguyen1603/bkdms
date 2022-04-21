import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:encrypt/encrypt.dart';
import 'package:basic_utils/basic_utils.dart';

import 'package:intl/intl.dart';

class TestMomo extends StatefulWidget {

  @override
  State<TestMomo> createState() => _TestMomoState();
}


class _TestMomoState extends State<TestMomo> {
  double myWidth = 90.w;
  //biến momo
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;
  //dấu biến hoàn tất + publickey
  bool isConfirm = false;
  final pem = """-----BEGIN RSA PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAoKsUUeWCPlJA+SUQOuie59vDkTMZKXIIDdOvxii/JYT/zW+niaJLlbaoTwW+/bUHz1zWz0uvUdy0H5Wm4/kjGrZUEh3lAuhOySThrr8zXMnS4EZtH2wA6gUORuxjcL2qH+JOE39SvjB5s6LvsfYI5efcUVJemVXdhIVUWv4hHS1TzMnstb0LBvw5s8TU+e2f+zeYdRTsNOgDScIYfWoFw7eMZHR+Nh/z2Yiu4kemo8Gv4wB+IDa9A9Q4I6kfr064DRbBMnhmGggQFq8qjTQRGM9RbR4CiIwkKqxB9hN9euuGfZfMoFh08czOFtgUB4VD/AUinDGSuazbh1Vrn90EOjymmRuRwKb2eLVcPrbKAdwxva8cLqQm2fhcTF/QtOI3Ibi5QuWr4hgfqps2Z+6C0vKzGgmxYc6PsMgvuELr62PeTaoSp2KBQgyILU+0UQehBA9DrUDRJwEOAMNxaOBgmiGwiwK91qLbMj5erlgWm2iYPldTsoWP7FnXYjamDYSu6qUMP61RFycr4b2bexNYQGFhfuwtxfJmvV/tU8v8Jj/0GxEfdrdnQYEeEha1gokudBRwnVKhPYpr0leM8hXhfCpIcPWZBcXvm4GH5C46oV+QHJe0b67AvcTnUra3nFwvh4vXdWcencsur7oNXy/0PGuKCCmDGOLYIU4NBl0xjhMCAwEAAQ==
-----END RSA PUBLIC KEY-----""";
  //biến nhập tiền
  final _formMoneyKey = GlobalKey<FormState>();
  final moneyController = TextEditingController();
  late int amout;
  
  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
      setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    //
    return  Scaffold(
        appBar: AppBarTransparent(Colors.white, "Thanh toán Momo"),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: 100.w,height: 30,),
              //hướng dẫn thanh toán
              SizedBox(
                width: myWidth,
                child: Row(children: [
                  //icon bell
                  Container(
                    alignment: Alignment.center,
                    height: myWidth*0.15,
                    width: myWidth*0.15,
                    decoration: BoxDecoration(
                      color: Color(0xfff9fafb),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ), 
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xff7b2626),
                    ),
                  ),
                  SizedBox(width: 3,),
                  //text hướng dẫn.
                  SizedBox(
                    width: myWidth*0.8,
                    child: Text(
                      "Hướng dẫn: nhập số tiền cần trả, sau đó xác nhận thanh toán tại ví điện tử Momo. Nhấn nút hoàn tất giao dịch để hoàn thành",
                      maxLines: 3,
                      style: TextStyle(color: Color(0xff544c4c)),                
                    ),
                  )              
                ]),
              ),
              SizedBox(height: 12,),

              //formfield nhập tiền
              Form(
                key: _formMoneyKey,
                child: SizedBox(
                  width: myWidth,
                  height: 50,
                  child: TextFormField(
                    controller: moneyController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nhập số tiền',
                      labelStyle: TextStyle(fontSize: 16),
                      prefixText: '\$',
                      suffixText: 'VND',
                      suffixStyle: TextStyle(color: Colors.green),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                         return 'không được để trống';
                      }
                      return null;
                    },             
                  ),
                ),
              ),
              SizedBox(height: 5,),
              
              //button open Momo app
              GestureDetector(
                onTap: () async{
                  //check form không null thì mở app Momo
                  if (_formMoneyKey.currentState!.validate()){
                    //update amout
                    setState(() {
                      this.amout = int.parse(moneyController.text);
                      print(amout);
                    });
                    //biến momo
                    MomoPaymentInfo options = MomoPaymentInfo(
                      merchantName: "Nhà cung cấp BKDMS",
                      appScheme: "momoawa120220330",
                      merchantCode: 'MOMOAWA120220330',
                      partnerCode: 'MOMOAWA120220330',
                      amount: this.amout, // đặt giá trị tiền vào đây
                      orderId: (int.parse(convertTime(DateTime.now().toString()))/100).round().toString(), // đặt id của giao dịch nợ
                      orderLabel: 'Nợ', 
                      merchantNameLabel: "Hệ thống quản lý phân phối BKDMS",
                      fee: 0,
                      description: 'Thanh toán nợ',
                      username: 'Cửa hàng #', // đặt tên cửa hàng agency ở đây
                      partner: 'merchant',
                      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                      isTestMode: true
                    );   
                    try {
                      _momoPay.open(options);   
                    } catch (e) {
                      debugPrint(e.toString());
                    } 
                  }               
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffe5efeb)),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ), 
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.double_arrow,
                    size: 26,
                    color: Color(0xff1dab87),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //text hiển thị nếu có lỗi xảy ra
              Text(_paymentStatus.isEmpty ? "" : _paymentStatus),
      
              //xác nhận momo thành công thì hiện button hoàn tất
              isConfirm
                ?ElevatedButton(
                  onPressed: () async{
                    //biến để encrypt
                    var pubkey = CryptoUtils.rsaPublicKeyFromPem(pem);
                    final dataEncode = jsonEncode(<String, dynamic>{
                      "partnerCode": 'MOMOAWA120220330',
                      "partnerRefId": (int.parse(convertTime(DateTime.now().toString()))/100).round().toString(),
                      "amount": this.amout,
                    });   
                    //hash dữ liệu gửi đi                     
                    final rsaEncrypt = Encrypter(RSA(publicKey: pubkey, encoding: RSAEncoding.PKCS1));
                    var hash = rsaEncrypt.encrypt("$dataEncode").base64;
                    await postMomoCallback(_momoPaymentResult.phoneNumber as String, _momoPaymentResult.token as String, hash);
                  },
                  child: Text("Hoàn tất giao dịch")
                 )
                : Text("")    
            ],
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }
  void _setState() { 
    isConfirm = false;
    if (_momoPaymentResult.isSuccess == true) {
      isConfirm =true;
    }
    else {
      _paymentStatus = 'Đã hủy thanh toán';
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }
  //xử lí khi xác nhận thành công 
  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "Xác nhận thành công: " + response.phoneNumber.toString(), toastLength: Toast.LENGTH_SHORT);
  }
  //xử lí khi xác nhận thất bại
  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), toastLength: Toast.LENGTH_SHORT);
  }

  //post pay momo
  Future<void> postMomoCallback(String phone, String token, String hash) async {
    var url = Uri.parse('https://test-payment.momo.vn' +'/pay/app');
    print(" bắt đầu post momo");
     try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }),
        body: jsonEncode(<String, dynamic>{
          "partnerCode": 'MOMOAWA120220330',
          "partnerRefId": "123",
          "customerNumber": phone,
          "appData": token,
          "hash": hash,
          'version': 2.0,
          "payType": 3,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200){
         print("kêt quả pay momo");
         print(response.statusCode);
      } else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }
  
  // Hàm convert thời gian tạo id giao dịch
  String convertTime(String time){
    var timeConvert = DateFormat('MMddHHmmss').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
 
}