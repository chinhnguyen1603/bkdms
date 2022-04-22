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
   late String totalPrice;
}

//service provider tại đây
class OrderProvider with ChangeNotifier{
   //biến dưới đây để create order
   static const purOrder ="PURCHASE_ORDER";
   late int totalPayment;
   late var listProduct;
   late String province;
   late String district ;
   late String ward;
   late String extra;
   late String phone;
   String note = '';

   //biến dưới đây để get order
   List<OrderInfo> lstOrderInfo = [];

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
    notifyListeners();
  }
  
  //http create order
  Future<void> createOrder(String? token, String? workspace, String? agencyId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/create-by-agency');
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

  //http get order (auto update list order)
  Future<void> getOrder(String? token, String? workspace, String? agencyId) async {
    //
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/get-order-by-agency');
    print(" bắt đầu get order");
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
      if (response.statusCode == 200){
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         final List<OrderInfo> loadListOrderInfo = [];
         extractedData['data']['listOrder'].forEach((orderData) {
         loadListOrderInfo.add(
          OrderInfo(
            id:  orderData['id'],
            orderCode: orderData['orderCode'],
            phone: orderData['phone'],
            address: orderData['address'],
            createTime: orderData['createTime'],
            approvedTime: orderData['approvedTime'],
            shippingTime: orderData['shippigTime'],
            completedTime: orderData['completedTime'],
            cancelledTimeByAgency: orderData['cancelledTimeByAgency'],
            cancelledTimeBySupplier: orderData['cancelledTimeBySupplier'],
            returnReason: orderData['returnReason'],
            waitingDeliveryTime: orderData['configDeliveryTime'],
            deliveryFailed: orderData['deliveryFailed'],
            deliveryFailedReason: orderData['deliveryFailedReason'],
            deliveredTime: orderData['deliveredTime'],
            deliveryStatus: orderData['deliveryStatus'],
            deliveryNote: orderData['deliveryNote'],
            deliveryVoucherCode: orderData['deliveryVoucherCode'],
            note: orderData['note'],
            orderStatus: orderData['orderStatus'],
            paymentStatus: orderData['paymentStatus'],
            type: orderData['type'],
            totalPayment: orderData['totalPayment'],
            totalDiscount: orderData['totalDiscount'],
            orderDetails: orderData['orderDetails']        
          ),
        );
      });
      this.lstOrderInfo = loadListOrderInfo;
      notifyListeners();
      } else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


  //http delete order
  Future<void> deleteOrder(String? token, String? workspace, String? agencyId, int orderId) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/order/cancel-order-by-agency');
    print(" bắt đầu delete order");
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
          'orderId': orderId,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201){
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



// list order info để get order
class OrderInfo {
  late int id;
  late String orderCode;
  late String phone;
  late String address;
  late String createTime;
  String? approvedTime;
  String? shippingTime;
  String? completedTime;
  String? cancelledTimeByAgency;
  String? cancelledTimeBySupplier;
  String? returnReason;
  String? waitingDeliveryTime;
  String? deliveredTime;
  String? deliveryFailed;
  String? deliveryFailedReason;
  String? deliveryStatus;
  String? deliveryNote;
  String? deliveryVoucherCode;
  String? note;
  late String orderStatus;
  String? paymentStatus;
  late String type;
  late String totalPayment;
  String? totalDiscount;
  late List<dynamic> orderDetails;

  OrderInfo({
    required this.id,
    required this.orderCode,
    required this.phone,
    required this.address,
    required this.createTime,
    this.approvedTime,
    this.shippingTime,
    this.completedTime,
    this.cancelledTimeByAgency,
    this.cancelledTimeBySupplier,
    this.returnReason,
    this.waitingDeliveryTime,
    this.deliveredTime,
    this.deliveryFailed,
    this.deliveryFailedReason,
    this.deliveryStatus,
    this.deliveryNote,
    this.deliveryVoucherCode,
    this.note,
    required this.orderStatus, 
    this.paymentStatus,
    required this.type,
    required this.totalPayment,
    required this.totalDiscount,
    required this.orderDetails,  
  });
}
