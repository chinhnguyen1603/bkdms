import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class OrderProvider with ChangeNotifier{
  static const purOrder ="PURCHASE_ORDER";
  //add cart
  // nhớ chuyển totalPayment thành String
  Future<void> createOrder(String? token, String? workspace, int? agencyId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/order/create-by-agency');
    print(" bắt đầu create order");
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
          'type': purOrder,
        }),
      );
      if (response.statusCode == 201){
         print("kêt quả create order");
         print(response.body);
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
