import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Cart.dart';

class CartProvider with ChangeNotifier{
  List<Cart> lstCart = [];
  
  //add cart
  Future<void> addCart(String? token, String? workspace, String? agencyId, String unitId, String quantity) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/cart');
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

  //get cart
  Future<List<Cart>> getCart(String? token, String? workspace, String? agencyId) async {
    var params = {
     "agencyId": "$agencyId", 
    };
    Uri uri = Uri.parse('https://bkdms.herokuapp.com' + '/mobile/api/v1/cart');
    final url = uri.replace(queryParameters: params);
    print("bắt đầu get cart");
    try {
      final response = await http.get(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
      );
      
      // thành công
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        final List<Cart> loadedCarts = [];
        extractedData['data']['productWithUnit'].forEach((cartData) {
          loadedCarts.add(
            Cart(
              id: cartData['id'],
              quantity: cartData['quantity'],
              unitId: cartData['unitId'],
              agencyId: cartData['agencyId'],
              unit: cartData['unit']
            ),
          );
        });
        this.lstCart = loadedCarts;
        notifyListeners();
        //test kết quả
        print(lstCart);
        return lstCart;
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

  //delete cart
  Future<void> deleteCart(String? token, String? workspace, String? agencyId, String uniId) async {

    final url = Uri.parse('https://bkdms.herokuapp.com' + '/mobile/api/v1/cart/deleteCart');
    print("bắt đầu delete cart");
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
          'unitId': uniId,
        }),
      );
      print(response.statusCode);
      // thành công
      if (response.statusCode == 200) {
        return ;
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

  //delete all cart
  Future<void> deleteAllCart(String? token, String? workspace, String? agencyId) async {

    final url = Uri.parse('https://bkdms.herokuapp.com' + '/mobile/api/v1/cart/delete-all-cart');
    print("bắt đầu delete tất cả cart");
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
      print(response.statusCode);
      // thành công
      if (response.statusCode == 200) {
        return ;
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

}
