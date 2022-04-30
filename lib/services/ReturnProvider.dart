import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Cart.dart';
import 'package:bkdms/models/OrderInfo.dart';

//list product để create return order
class Product {
   late String quantity;
   late String price;
   late String unitId;
   late String totalPrice;
}


class ReturnProvider with ChangeNotifier{
   //biến dưới đây để create retrun order
   static const purOrder ="RETURN_ORDER";
   late int totalPayment;
   late var listProduct;
   late String province;
   late String district ;
   late String ward;
   late String extra;
   late String phone;
   String returnReason = '';


   void setPhoneAndNote(String newPhone, String newNote){
     this.phone = newPhone;
     this.returnReason = newNote;
     notifyListeners();
   }
   void setAddress(String newProvince, String newDistrict, String newWard, String newExtra){
     this.province = newProvince;
     this.district = newDistrict;
     this.ward = newWard;
     this.extra = newExtra; 
     notifyListeners();
   }

   void setTotalPayment(int money){
     this.totalPayment = money;
     notifyListeners();
   } 

  void setListProduct(List<dynamic> lstCart){
     this.listProduct = lstCart.map((eachCart) => ({
       'quantity': eachCart['quantity'],
       'price': eachCart['price'],
       'unitId': eachCart['unitId'],
       'totalPrice': (int.parse(eachCart['quantity'])*int.parse(eachCart['price'])).toString(),
    })).toList();
    notifyListeners();
  }
  
  //http create return order
  Future<void> createReturnOrder(String token, String workspace, String agencyId, String orderId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/create-by-agency');
    print(" bắt đầu create return order");
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
          'phone': this.phone,
          'extraInfoOfAddress': this.extra,
          'returnReason': this.returnReason,
          'province': this.province,
          'district': this.district,
          'ward': this.ward, 
          'totalPayment':this.totalPayment.toString(),
          'listProduct': this.listProduct,
          'agencyId': agencyId,
          'type': purOrder,
          'orderId': orderId,
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