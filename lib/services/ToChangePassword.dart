import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<dynamic>> postNewPassword(String? token, String? workspace, String? agencyId, String oldPassword, String newPassword) async {
  print("bắt đầu Đổi mật khẩu");
  //try catch
  try{
   var url = Uri.parse('https://bkdms.herokuapp.com' + '/mobile/api/v1/changeInfo/changePass/agency');
   final response = await http.post(
     url,
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization': 'Bearer $token',
       'Workspace' : "$workspace",
     },
     body: jsonEncode(<String, dynamic>{
       'id': agencyId,
       'oldPassword': oldPassword,
       'newPassword': newPassword,
     }),
   );
   print(response.statusCode);
   if (response.statusCode == 200) {
     print(response.body);
     return jsonDecode("[" + response.body + "]");
   } 
   else {
     throw jsonDecode(response.body.toString());
   }
  }
  catch(e){
    throw e;
  }
}

