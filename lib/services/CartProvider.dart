import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Cart.dart';

class CartProvider with ChangeNotifier{
  List<Cart> lstCart = [];
  
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
      print("kêt quả add cart");
      print(response.statusCode);
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


  Future<List<Cart>> getCart(String? token, String? workspace, int? agencyId) async {
    var params = {
     "agencyId": "$agencyId",
    };
    Uri uri = Uri.parse('https://bkdms.herokuapp.com' + '/api/v1/cart');
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
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.statusCode);//test status code
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
    catch (error) {
      print(error);
      throw error;
    }
  }

}
