import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Agency> postAPI(String phone, String password, String workspace) async {
  print("bắt đầu post API");
  var url = Uri.parse('https://bkdms.herokuapp.com' + '/api/v1/auth/login-agency');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
      'password': password,
      'workspace': workspace,
    }),
  );
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    return Agency.fromJson(jsonDecode(response.body));
  } 
  else {
    throw Exception('Thông tin đăng nhập chưa chính xác');
  }
}

class Agency {
  final String phone;
  final String password;
  final String workspace;
  final String province;

  const Agency({required this.phone, required this.password, required this.workspace, required this.province});

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      phone: json['data']['user']['phone'] as String,
      password: json['data']['user']['password'] as String,
      workspace: json['data']['user']['workspace'] as String,
      province:  json['data']['user']['province'] as String
    );
  }
}