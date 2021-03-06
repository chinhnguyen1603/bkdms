import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Agency.dart';

Future<Agency> postAPI(String phone, String password, String workspace, String fcmToken) async {
  print("bắt đầu Login");
  try{
   var url = Uri.parse('https://bkdms.herokuapp.com' + '/api/v1/auth/login-agency');
   final response = await http.post(
     url,
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
       'Charset': 'utf-8'
     },
     body: jsonEncode(<String, String>{
       'phone': phone,
       'password': password,
       'workspace': workspace,
       'fcmToken': fcmToken,
     }),
   );
   print(response.statusCode);
   if (response.statusCode == 200) {
     return Agency.fromJson(jsonDecode(response.body));
   } 
   else {
     throw jsonDecode(response.body.toString());
   }
  }//try
  catch(e){
    throw e;
  }
}

