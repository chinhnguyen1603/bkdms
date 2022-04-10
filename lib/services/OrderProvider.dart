import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class OrderProvider with ChangeNotifier{
  static const purOrder ="PURCHASE_ORDER";
  late int totalPayment;
   late List<dynamic> listProduct;
   late String province;
   late String district ;
   late String ward;
   late String extra;
   late String phone;
   String note = "";
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

  // nhớ chuyển totalPayment thành String
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
          'type': "cc",
          'agencyId': agencyId,
          
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
