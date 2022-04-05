import 'package:flutter/cupertino.dart';
class TotalPayment with ChangeNotifier{
   int totalPayment = 0;
   void setTotalPayment(int money){
     this.totalPayment = money;
     notifyListeners();
   }

}