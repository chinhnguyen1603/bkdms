import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/CartBarcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Cart.dart';

//list product để create order
class Product {
   late String quantity;
   late String price;
   late String unitId;
}

class ConsumerProvider with ChangeNotifier{
  late String name;
  late String phone;
  late var listProduct;
  void setNameAndPhone (String newName, String newPhone){
     this.name = newName;
     this.phone = newPhone;
     notifyListeners();
  }
  //
  void setListProduct(List<CartBarcode> lstCart){
    this.listProduct = lstCart.map((eachCart) => ({
       'quantity': eachCart.quantity,
       'price': eachCart.price,
       'unitId': eachCart.unitId,
    })).toList();
  }


  //post update doanh thu agency
  Future<Agency> getRevenue(String token, String workspace, String agencyId) async {
    print("bắt đầu update Revenue");
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
           revenue: extractedData['agency']['revenue'],
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

  //http create order
  Future<void> createSale(String token, String workspace, String agencyId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/create-for-end-consumer');
    print(" bắt đầu create Sale");
    print(this.name);
    print(this.listProduct);
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
          'name': this.name,        
          'phone': this.phone, 
          'listProduct': this.listProduct,
          'agencyId': agencyId,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201){
         print("thành công");
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