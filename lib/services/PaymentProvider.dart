import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/PayHistoryInfo.dart';


class PaymentProvider with ChangeNotifier{
  List<PayHistoryInfo> lstPayHistory = [];

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
      if(response.statusCode ==200){
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
         return Agency.getApi(
           id: extractedData['data']['agency']['id'], 
           name: extractedData['data']['agency']['name'], 
           nameOwn: extractedData['data']['agency']['nameOwn'],
           phone: extractedData['data']['agency']['phone'],
           dateJoin: extractedData['data']['agency']['dateJoin'],
           province: extractedData['data']['agency']['province'],
           district: extractedData['data']['agency']['district'],
           ward: extractedData['data']['agency']['ward'],
           extraInfoOfAddress: extractedData['data']['agency']['extraInfoOfAddress'],
           workspace: extractedData['data']['agency']['workspace'], 
           maxDebt: extractedData['data']['agency']['maxDebt'],
           maxDebtPeriod: extractedData['data']['agency']['maxDebtPeriod'],
           currentTotalDebt: extractedData['data']['agency']['currentTotalDebt'],
           debtStartTime: extractedData['data']['agency']['debtStartTime'],
           revenue: extractedData['data']['agency']['revenue'],
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
    }
    catch (error) {
      print(error);
      throw error;
    }  
  }

  //lấy lịch sử thanh toán
  Future<void> getPayHistory(String token, String workspace, String agencyId) async {
    print("bắt đầu get Pay History");

    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/payment/get-all-payment-agency');
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
      if (response.statusCode == 200){
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         final List<PayHistoryInfo> loadListPayHistory = [];
         extractedData['data']['listPayment'].forEach((payHistory) {
         loadListPayHistory.add(
          PayHistoryInfo(
            id:  payHistory['id'],
            amount: payHistory['amount'],
            time: payHistory['time'],
            type: payHistory['type'],       
          ),
        );
      });
      this.lstPayHistory = loadListPayHistory;
      notifyListeners();
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


