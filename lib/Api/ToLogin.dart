import 'package:http/http.dart' as http;
import 'dart:convert';

/*class ToLogin{
  // variable
  String phone;
  String password;
  String workspace;
  late Map<String, dynamic> bodyResponse;
  //constructor
  ToLogin(this.phone, this.password, this.workspace);
  
  void postToLogin() async {
     print("bắt đầu post API");
     //parameter of POST 
     String url = 'https://bkdms.herokuapp.com/api/v1/auth/login-agency';
     Map<String, String> headers = {
       "Content-type": "application/json"
     };

     //file json gửi thẳng lên server    
     String json = '{"phone": "$phone", "password": "$password", "workspace": "$workspace"}';
     // tạo POST request
     Response response = await post(
       url, 
       headers: headers, 
       body: json
     );
     
     //xử lý sau khi nhận response
     int statusCode = response.statusCode;
     print(statusCode); 
     this.bodyResponse = jsonDecode(response.body);
     print(bodyResponse);
  }

}*/