import 'package:flutter/cupertino.dart';
class CountBadge with ChangeNotifier{
   int counter = 0;
   void setCounter(int length){
     this.counter = length;
     notifyListeners();
   }

}