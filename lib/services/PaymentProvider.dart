import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Level.dart';
import 'package:bkdms/models/Agency.dart';


class PaymentProvider with ChangeNotifier{

  //post update nợ agency
  Future<Agency> getDebt(String token, String workspace, String agencyId) async {
    print("bắt đầu update Debt");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/agency');
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
        body: jsonEncode(<String, dynamic>{
          'agencyId': agencyId,
        }),
      );
      //test kết quả
      print(response.statusCode);
      print(response.body);
      if(response.statusCode ==200){
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
         return Agency.getApi(
           id: extractedData['agency']['id'], 
           name: extractedData['agency']['name'], 
           nameOwn: extractedData['agency']['nameOwn'],
           phone: extractedData['agency']['phone'],
           dateJoin: extractedData['agency']['dateJoin'],
           province: extractedData['agency']['province'],
           district: extractedData['agency']['district'],
           ward: extractedData['agency']['ward'],
           extraInfoOfAddress: extractedData['agency']['extraInfoOfAddress'],
           workspace: extractedData['agency']['workspace'], 
           maxDebt: extractedData['agency']['maxDebt'],
           maxDebtPeriod: extractedData['agency']['maxDebtPeriod'],
           currentTotalDebt: extractedData['agency']['currentTotalDebt'],
           debtStartTime: extractedData['agency']['debtStartTime'],
           token: token,
         );
      } else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }  
  }

  //post thanh toán online
  Future<void> postOnlinePay(String token, String workspace, String agencyId, String amout) async {
    print("bắt đầu post thanh toán");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/payment');
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
        body: jsonEncode(<String, dynamic>{
          'agencyId': agencyId,
          'type': 'ONLINE_PAYMENT',
          'amount': amout,
        }),
      );
      //test kết quả
      print(response.statusCode);
      print(response.body);
      /*
      if(response.statusCode ==200){
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
         return Agency.getApi(
           id: extractedData['agency']['id'], 
           name: extractedData['agency']['name'], 
           nameOwn: extractedData['agency']['nameOwn'],
           phone: extractedData['agency']['phone'],
           dateJoin: extractedData['agency']['dateJoin'],
           province: extractedData['agency']['province'],
           district: extractedData['agency']['district'],
           ward: extractedData['agency']['ward'],
           extraInfoOfAddress: extractedData['agency']['extraInfoOfAddress'],
           workspace: extractedData['agency']['workspace'], 
           maxDebt: extractedData['agency']['maxDebt'],
           maxDebtPeriod: extractedData['agency']['maxDebtPeriod'],
           currentTotalDebt: extractedData['agency']['currentTotalDebt'],
           debtStartTime: extractedData['agency']['debtStartTime'],
           token: token,
         );
      } else{
        throw jsonDecode(response.body.toString());
      }*/
    }
    catch (error) {
      print(error);
      throw error;
    }  
  }


}
