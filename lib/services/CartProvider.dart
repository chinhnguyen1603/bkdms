import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';




  Future<void> addCart(String? token, String? workspace, int? agencyId, int unitId, String quantity) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/cart');
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
          'unitId': unitId,
          'quantity': quantity,
        }),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(" post thử cart");
      print(response.statusCode);
      print(extractedData);
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


  Future<void> getCart(String? token, String? workspace, int? agencyId) async {

    //var url = Uri.parse('https://bkdms.herokuapp.com' + '/api/v1/cart?' + 'agencyId = $agencyId');
    var params = {
      "agencyId": "$agencyId",
    };

    Uri uri = Uri.parse('https://bkdms.herokuapp.com' + '/api/v1/cart?');
    final url = uri.replace(queryParameters: params);
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(" get thử cart");
      print(response.statusCode);
      print(extractedData);
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


