import 'package:flutter/cupertino.dart';

class ListProduct {

}


class InfoOfOrder with ChangeNotifier{
   late int totalPayment;
   late List<dynamic> listProduct;
   late String province;
   late String district ;
   late String ward;
   late String extra;
   late String phone;
   String note = "";
   void setPhone(String newPhone){
     this.phone = newPhone;
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

}