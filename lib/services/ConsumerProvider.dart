import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/CartBarcode.dart';
import 'package:bkdms/models/SaleOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//list product để create order
class Product {
   late String quantity;
   late String price;
   late String unitId;
}

class ConsumerProvider with ChangeNotifier{
  //biến lấy lịch sử bán lẻ
  List<SaleOrder> lstSaleOrder = [];
  //biến để tạo đơn bán lẻ 
  late String name;
  late String phone;
  late var listProduct;
  //
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
      print(response.body);
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

  //http create sale order
  Future<void> createSale(String token, String workspace, String agencyId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/create-for-end-consumer');
    print(" bắt đầu create Sale");
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

  //http get lịch sử đơn bán
  Future<void> saleHistory(String token, String workspace, String agencyId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/get-order-for-end-consumer');
    print(" bắt đầu get lịch sử sale");
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
      print(response.body);
      if(response.statusCode == 200){
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        final List<SaleOrder> loadedSaleOrder = [];
        extractedData['data']['listOrder'].forEach((orderData) {
            loadedSaleOrder.add(
              SaleOrder(
                id: orderData['id'],
                orderCode: orderData['orderCode'],
                totalPrice: orderData['totalPrice'],
                name: orderData['name'],
                phone: orderData['phone'],
                createTime: orderData['createTime'],
                detailOrderEndConsumers: orderData['detailOrderEndConsumers'],
              ),
            );
        });
        this.lstSaleOrder = loadedSaleOrder;
        notifyListeners();
      } 
      else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

}