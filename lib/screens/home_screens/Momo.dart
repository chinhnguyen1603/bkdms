import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:basic_utils/basic_utils.dart';

class TestMomo extends StatefulWidget {

  @override
  State<TestMomo> createState() => _TestMomoState();
}


class _TestMomoState extends State<TestMomo> {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;
  final pem = """-----BEGIN RSA PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAoKsUUeWCPlJA+SUQOuie59vDkTMZKXIIDdOvxii/JYT/zW+niaJLlbaoTwW+/bUHz1zWz0uvUdy0H5Wm4/kjGrZUEh3lAuhOySThrr8zXMnS4EZtH2wA6gUORuxjcL2qH+JOE39SvjB5s6LvsfYI5efcUVJemVXdhIVUWv4hHS1TzMnstb0LBvw5s8TU+e2f+zeYdRTsNOgDScIYfWoFw7eMZHR+Nh/z2Yiu4kemo8Gv4wB+IDa9A9Q4I6kfr064DRbBMnhmGggQFq8qjTQRGM9RbR4CiIwkKqxB9hN9euuGfZfMoFh08czOFtgUB4VD/AUinDGSuazbh1Vrn90EOjymmRuRwKb2eLVcPrbKAdwxva8cLqQm2fhcTF/QtOI3Ibi5QuWr4hgfqps2Z+6C0vKzGgmxYc6PsMgvuELr62PeTaoSp2KBQgyILU+0UQehBA9DrUDRJwEOAMNxaOBgmiGwiwK91qLbMj5erlgWm2iYPldTsoWP7FnXYjamDYSu6qUMP61RFycr4b2bexNYQGFhfuwtxfJmvV/tU8v8Jj/0GxEfdrdnQYEeEha1gokudBRwnVKhPYpr0leM8hXhfCpIcPWZBcXvm4GH5C46oV+QHJe0b67AvcTnUra3nFwvh4vXdWcencsur7oNXy/0PGuKCCmDGOLYIU4NBl0xjhMCAwEAAQ==
-----END RSA PUBLIC KEY-----""";
 final dataEncode = jsonEncode(<String, dynamic>{
     "partnerCode": 'MOMOAWA120220330',
     "partnerRefId": '123',
     "amount": 200000,
  });
  
  
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
    MomoPaymentInfo options = MomoPaymentInfo(
      merchantName: "BKDMS",
      appScheme: "momoawa120220330",
      merchantCode: 'MOMOAWA120220330',
      partnerCode: 'MOMOAWA120220330',
      amount: 200000, // đặt giá trị tiền vào đây
      orderId: '123', // đặt id của giao dịch nợ
      orderLabel: 'Nợ', 
      merchantNameLabel: "Hệ thống quản lý phân phối BKDMS",
      fee: 0,
      description: 'Thanh toan no',
      username: 'Cửa hàng #', // đặt tên cửa hàng agency ở đây
      partner: 'merchant',
      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
      isTestMode: true
    );
    var pubkey = CryptoUtils.rsaPublicKeyFromPem(pem);
    return  Scaffold(
        appBar: AppBar(
          title: Text('THANH TOÁN QUA ỨNG DỤNG MOMO'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  ElevatedButton(
                    child: Text('Xác nhận'),
                    onPressed: () async {
                      try {
                        _momoPay.open(options);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                ],
              ),
              Text(_paymentStatus.isEmpty ? "CHƯA THANH TOÁN" : _paymentStatus),
              ElevatedButton(
                onPressed: () async{
                  final rsaEncrypt = Encrypter(RSA(publicKey: pubkey, encoding: RSAEncoding.PKCS1));
                  var hash = rsaEncrypt.encrypt("$dataEncode").base64;
                  await postMomoCallback(_momoPaymentResult.phoneNumber as String, _momoPaymentResult.token as String, hash);
                },
                child: Text("Thanh toán")
              )
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
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nstatus: " + _momoPaymentResult.status.toString();
      _paymentStatus += "\nmessage: " + _momoPaymentResult.message.toString();
      _paymentStatus += "\nphone number: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
    }
    else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }
  //void show toast 
  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phoneNumber.toString(), toastLength: Toast.LENGTH_SHORT);
  }

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
      if (response.statusCode == 201){
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
 
}