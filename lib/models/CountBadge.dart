import 'package:flutter/cupertino.dart';
class CountBadge with ChangeNotifier{
   int counter = 0;
   void updatePlus(){
     this.counter++;
     notifyListeners();
   }
   void updateMinus(){
     if(this.counter>0){
       this.counter--;
     }
     notifyListeners();
   }
  

}