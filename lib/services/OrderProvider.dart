import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Item.dart';


class OrderProvider with ChangeNotifier{
  List<Item> lstItem = [];
  //add cart
  Future<void> addCart(String? token, String? workspace, int? agencyId, int unitId, String quantity) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/cart');
    print(" bắt đầu add cart");
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
      if (response.statusCode == 201){
         print("kêt quả add cart");
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
