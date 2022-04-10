import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Cart.dart';


class Product {
   late String quantity;
   late String price;
   late String unitId;
   late String totalPrice;
}

class OrderProvider with ChangeNotifier{
  
   static const purOrder ="PURCHASE_ORDER";
   late int totalPayment;
   late var listProduct;
   late String province;
   late String district ;
   late String ward;
   late String extra;
   late String phone;
   String note = '';

   void setPhoneAndNote(String newPhone, String newNote){
     this.phone = newPhone;
     this.note = newNote;
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

  void setListProduct(List<Cart> lstCart){
     this.listProduct = lstCart.map((eachCart) => ({
       'quantity': eachCart.quantity,
       'price': eachCart.unit['agencyPrice'],
       'unitId': eachCart.unitId,
       'totalPrice': (int.parse(eachCart.quantity)*int.parse(eachCart.unit['agencyPrice'])).toString(),
    })).toList();
    print(listProduct[0] );
    print( listProduct[1]);
    notifyListeners();
  }
  
  //http create order
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
          'phone': this.phone,
          'extraInfoOfAddress': this.extra,
          'note': this.note,
          'returnReason': '',
          'province': this.province,
          'district': this.district,
          'ward': this.ward, 
          'totalPayment':this.totalPayment.toString(),
          'listProduct': this.listProduct,
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
